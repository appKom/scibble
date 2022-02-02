import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'dart:math';

class PKCEToken {
  String challenge;
  String verifier;
  String clientId;
  String _state;

  String get authenticateUrl => Uri(
        scheme: 'https',
        path: 'online.ntnu.no/openid/authorize',
        queryParameters: {
          'client_id': clientId,
          'redirect_uri': 'com.example.scibble://login',
          'response_type': 'code',
          'code_challenge': challenge,
          'code_challenge_method': 'S256',
          'state': _state,
          'scope': 'onlineweb4',
        },
      ).toString();

  PKCEToken._({
    required this.challenge,
    required this.verifier,
    required this.clientId,
  }) : this._state = randomString(128);

  factory PKCEToken(String clientId) {
    String verifier = randomString(128);
    return PKCEToken._(
      clientId: clientId,
      verifier: verifier,
      challenge: _stringToSha256(verifier),
    );
  }

  static String _stringToSha256(String string) {
    var hash = sha256.convert(utf8.encode(string));
    var cleanHash = base64Url
        .encode(hash.bytes)
        .replaceAll("=", "")
        .replaceAll("+", "-")
        .replaceAll("/", "_");
    return cleanHash;
  }

  static String randomString(int chars) {
    Random randomGenerator = Random.secure();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(
      Iterable.generate(
        chars,
        (_) => _chars.codeUnitAt(
          randomGenerator.nextInt(_chars.length),
        ),
      ),
    );
  }
}
