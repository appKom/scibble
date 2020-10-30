import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:scibble/models/auth_pkce.dart';
import 'package:scibble/models/token.dart';
import 'package:scibble/models/user.dart';
import 'package:scibble/redux/authentication/actions.dart';
import 'package:scibble/redux/authentication/reducer.dart';
import 'package:scibble/redux/authentication/state.dart';
import 'package:scibble/redux/user/actions.dart';
import 'package:scibble/redux/user/reducer.dart';

import '../models/user_test.dart';

void main() {
  group('User reducer', () {
    final initialState = null;
    final mockUser = User.fromJson(json.decode(mockJsonUser));
    test('Test set user', () {
      final newState = userReducer(initialState, SetUser(mockUser));
      expect(mockUser, newState);
    });
    test('Test return same state', () {
      final newState = userReducer(initialState, SetToken(null));
      expect(initialState, newState);
    });
  });
}
