import 'dart:convert';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:scibble/OnlineWeb/Authentication.dart';
import 'package:scibble/OnlineWeb/Token.dart';
import 'package:scibble/OnlineWeb/User.dart';
import 'package:scibble/Store/AppState.dart';

class SetAuthentication {
  final Authentication payload;
  SetAuthentication(this.payload);
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
  var response = await http.post(
    'https://online.ntnu.no/openid/token',
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'authorization_code',
      'code': store.state.auth.code,
      'redirect_uri': 'http://localhost:6969/#/',
      'client_id': store.state.auth.clientId,
      'code_verifier': store.state.auth.verifier,
    },
  );
  if (response.statusCode == 200) {
    Token token = Token.fromJson(json.decode(response.body));
    store.dispatch(SetToken(token));
  }
};

ThunkAction<AppState> getUserProfile = (Store<AppState> store) async {
  var response = await http.get(
    'https://online.ntnu.no/api/v1/profile/',
    headers: {'Authorization': 'Bearer ${store.state.token.accessToken}'},
  );
  var user = User.fromJson(json.decode(response.body));
  await store.dispatch(SetUser(user));
  await store.dispatch(NavigateToAction.replace('/home'));
};
