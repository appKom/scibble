import 'package:flutter/material.dart';
import 'package:scibble/redux/authentication/Reducer.dart';
import 'package:scibble/redux/authentication/state.dart';

class AppState {
  final AuthenticationState auth;

  AppState({@required this.auth});

  factory AppState.initialState(String clientId) => AppState(
        auth: AuthenticationState.initialState(clientId),
      );
}

AppState reducer(AppState state, dynamic action) => new AppState(
      auth: authenticationReducer(state.auth, action),
    );
