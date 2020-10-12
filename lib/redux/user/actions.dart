import 'dart:convert';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:scibble/models/user.dart';
import 'package:scibble/redux/store.dart';

class SetUser {
  final User payload;
  SetUser(this.payload);
}

class Logout {
  Logout();
}

ThunkAction<AppState> getUserProfile = (Store<AppState> store) async {
  final token = store.state.auth.token;
  var response = await http.get(
    'https://online.ntnu.no/api/v1/profile/',
    headers: {'Authorization': 'Bearer ${token.accessToken}'},
  );
  var user = User.fromJson(json.decode(response.body));
  await store.dispatch(SetUser(user));
  await store.dispatch(NavigateToAction.replace('/home'));
};

ThunkAction<AppState> logoutUser = (Store<AppState> store) async {
  await store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
      '/', (route) => route.settings.name == '/'));
  await store.dispatch(Logout());
};
