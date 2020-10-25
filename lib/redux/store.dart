import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:scibble/models/product.dart';
import 'package:scibble/models/user.dart';
import 'package:scibble/redux/authentication/reducer.dart';
import 'package:scibble/redux/authentication/state.dart';
import 'package:scibble/redux/inventory/reducer.dart';
import 'package:scibble/redux/user/actions.dart';

import 'user/reducer.dart';

class AppState {
  final AuthenticationState auth;
  final List<Product> inventory;
  final User user;

  AppState({@required this.auth, @required this.inventory, @required this.user});

  factory AppState.initialState(String clientId) => AppState(
        auth: AuthenticationState.initialState(clientId),
        inventory: null,
        user: null
      );
}

AppState reducer(AppState state, dynamic action) {
  if (action is Logout) {
    return new AppState.initialState(state.auth.authPKCEState.pkce.clientId);
  }
  return new AppState(
    auth: authenticationReducer(state.auth, action),
    user: userReducer(state.user, action),
    inventory: inventoryReducer(state.inventory, action)
  );
}