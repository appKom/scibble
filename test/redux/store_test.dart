import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:scibble/models/user.dart';
import 'package:scibble/redux/store.dart';
import 'package:scibble/redux/user/actions.dart';

import '../models/user_test.dart';

void main() {
  group('Redux store', () {
    final initialStore = AppState.initialState("12345");
    test('Initialize store test', () {
      expect(null, initialStore.user);
      expect(0, initialStore.inventory.length);
      expect("12345", initialStore.auth.authPKCEState.pkce.clientId);
    });
    test('Log out user test', () {
      final mockUser = User.fromJson(json.decode(mockJsonUser));
      final loggedInUserStore = reducer(initialStore, SetUser(mockUser));
      expect(mockUser, loggedInUserStore.user);
      final loggedOutUserStore = reducer(loggedInUserStore, Logout());
      expect(null, loggedOutUserStore.user);
    });
  });
}
