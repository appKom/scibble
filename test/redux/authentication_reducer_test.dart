import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:scibble/models/auth_pkce.dart';
import 'package:scibble/models/token.dart';
import 'package:scibble/models/user.dart';
import 'package:scibble/redux/authentication/actions.dart';
import 'package:scibble/redux/authentication/reducer.dart';
import 'package:scibble/redux/authentication/state.dart';

import '../../models/token_test.dart';
import '../../models/user_test.dart';

void main() {
  group('Authentication state (Redux)', () {
    group('User reducer', () {
      final mockUser = User.fromJson(json.decode(mockJsonUser));
      test('Test set user', () {
        final state = UserState(user: null);
        final newState = userReducer(state, SetUser(mockUser));
        expect(mockUser, newState.user);
      });
      test('Test bad action', () {
        final state = UserState(user: null);
        final newState = userReducer(state, SetToken(null));
        expect(state.user, newState.user);
      });
    });

    group('Token reducer', () {
      final mockToken = Token.fromJson(json.decode(mockTokenString));
      test('Test set token', () {
        final state = TokenState(token: null);
        final newState = tokenReducer(state, SetToken(mockToken));
        expect(mockToken, newState.token);
      });
      test('Test bad action', () {
        final state = TokenState(token: null);
        final newState = tokenReducer(state, SetUser(null));
        expect(state.token, newState.token);
      });
    });

    group('Authentication with PKCE reducer', () {
      final mockAuthPKCE = AuthPKCE("123456789");
      test('Test set auth', () {
        final state = AuthPKCEState(pkce: null);
        final newState = authPKCEReducer(state, SetAuthPKCE(mockAuthPKCE));
        expect(mockAuthPKCE, newState.pkce);
      });
      test('Test bad action', () {
        final state = AuthPKCEState(pkce: null);
        final newState = authPKCEReducer(state, SetUser(null));
        expect(state.pkce, newState.pkce);
      });
    });
  });
}
