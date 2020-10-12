import 'package:flutter/material.dart';

import 'package:scibble/models/user.dart';
import 'package:scibble/redux/authentication/reducer.dart';
import 'package:scibble/redux/authentication/state.dart';
import 'package:scibble/redux/user/actions.dart';
import 'package:scibble/redux/user/reducer.dart';

class AppState {
  final AuthenticationState auth;
  final User user;

  AppState({@required this.auth, @required this.user});

  factory AppState.initialState(String clientId) => AppState(
        auth: AuthenticationState.initialState(clientId),
        user: null,
      );
}

AppState reducer(AppState state, dynamic action) {
  if (action is Logout) {
    return new AppState.initialState(state.auth.authPKCEState.pkce.clientId);
  }
  return new AppState(
    auth: authenticationReducer(state.auth, action),
    user: userReducer(state.user, action),
  );
}
