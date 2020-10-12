import 'dart:convert';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:scibble/models/auth_pkce.dart';
import 'package:scibble/models/token.dart';
import 'package:scibble/models/user.dart';
import 'package:scibble/redux/store.dart';

class SetAuthPKCE {
  AuthPKCE payload;
  SetAuthPKCE(this.payload);
}

class SetCode {
  String payload;
  SetCode(this.payload);
}

class SetToken {
  final Token payload;
  SetToken(this.payload);
}

class SetUser {
  final User payload;
  SetUser(this.payload);
}

ThunkAction<AppState> tradeCodeForToken = (Store<AppState> store) async {
  final state = store.state.auth.authPKCEState;
  var response = await http.post(
    'https://online.ntnu.no/openid/token',
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'authorization_code',
      'code': state.code,
      'redirect_uri': 'http://localhost:6969/#/',
      'client_id': state.pkce.clientId,
      'code_verifier': state.pkce.verifier,
    },
  );
  if (response.statusCode == 200) {
    Token token = Token.fromJson(json.decode(response.body));
    store.dispatch(SetToken(token));
  }
};

ThunkAction<AppState> getUserProfile = (Store<AppState> store) async {
  final token = store.state.auth.tokenState.token;
  var response = await http.get(
    'https://online.ntnu.no/api/v1/profile/',
    headers: {'Authorization': 'Bearer ${token.accessToken}'},
  );
  var user = User.fromJson(json.decode(response.body));
  await store.dispatch(SetUser(user));
  await store.dispatch(NavigateToAction.replace('/home'));
};
