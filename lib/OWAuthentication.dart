import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:random_string/random_string.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Token.dart';

class OWAuthentication {
  static const _authenticationBase = 'online.ntnu.no/openid';
  String _challenge;
  String _verifier;
  String _clientId;
  String _state;
  Token _token;

  get token => _token;
  get challenge => _challenge;
  get verifier => _verifier;

  OWAuthentication(this._clientId) {
    _verifier = window.sessionStorage['verifier'];
    if (_verifier == null) {
      _verifier = randomString(128);
      window.sessionStorage['verifier'] = _verifier;
    }
    _challenge = stringToSha256(_verifier);
    _state = randomString(128);
  }

  String stringToSha256(String string) {
    var hash = sha256.convert(utf8.encode(string));
    var cleanHash = base64Url
        .encode(hash.bytes)
        .replaceAll("=", "")
        .replaceAll("+", "-")
        .replaceAll("/", "_");
    return cleanHash;
  }

  String authorizationCode() {
    final href = window.location.href;
    var authorizationCode = Uri.dataFromString(href).queryParameters['code'];
    final authorizationState =
        Uri.dataFromString(href).queryParameters['state'];
    window.history.replaceState({}, document.title, '/');
    return authorizationCode;
  }

  authenticate() {
    final uri = Uri(
      scheme: 'https',
      path: '$_authenticationBase/authorize',
      queryParameters: {
        'client_id': _clientId,
        'redirect_uri': 'http://localhost:6969/#/',
        'response_type': 'code',
        'code_challenge': _challenge,
        'code_challenge_method': 'S256',
        'state': _state,
        'scope': 'onlineweb4',
      },
    );
    launchUri(uri);
  }

  void tradeCodeForToken(String code) async {
    var response = await http.post(
      'https://$_authenticationBase/token',
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': 'http://localhost:6969/#/',
        'client_id': _clientId,
        'code_verifier': _verifier,
      },
    );
    if (response.statusCode == 200) {
      _token = Token.fromJson(json.decode(response.body));
    }
  }

  Future<void> launchUri(Uri uri) async {
    final uriString = uri.toString();
    if (await canLaunch(uriString)) {
      await launch(
        uriString,
        forceSafariVC: true,
        forceWebView: true,
        webOnlyWindowName: '_self',
      );
    } else {
      throw 'Could not launch $uriString';
    }
  }
}