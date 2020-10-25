import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:scibble/models/product.dart';
import 'package:scibble/redux/authentication/reducer.dart';
import 'package:scibble/redux/authentication/state.dart';
import 'package:scibble/redux/inventory/reducer.dart';

class AppState {
  final AuthenticationState auth;
  final List<Product> inventory;

  AppState({@required this.auth, @required this.inventory});

  factory AppState.initialState(String clientId) => AppState(
        auth: AuthenticationState.initialState(clientId),
        inventory: null
      );
}

class Logout {
  Logout();
}

ThunkAction<AppState> logoutUser = (Store<AppState> store) async {
  await store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(
      '/', (route) => route.settings.name == '/'));
  await store.dispatch(Logout());
};

AppState reducer(AppState state, dynamic action) => new AppState(
      auth: authenticationReducer(state.auth, action),
      inventory: inventoryReducer(state.inventory, action)
    );
