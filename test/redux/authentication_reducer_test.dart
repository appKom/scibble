import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:scibble/models/auth_pkce.dart';
import 'package:scibble/models/token.dart';
import 'package:scibble/redux/authentication/actions.dart';
import 'package:scibble/redux/authentication/reducer.dart';
import 'package:scibble/redux/authentication/state.dart';
import 'package:scibble/redux/user/actions.dart';

import '../models/token_test.dart';

void main() {
  group('Authentication state (Redux)', () {
    group('Token reducer', () {
      final mockToken = Token.fromJson(json.decode(mockTokenString));
      final initialState = null;
      test('Test set token', () {
        final newState = tokenReducer(initialState, SetToken(mockToken));
        expect(mockToken, newState);
      });
      test('Test return same state', () {
        final newState = tokenReducer(initialState, SetUser(null));
        expect(initialState, newState);
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

    group('AuthenticationState', () {
      test('Initialize state', () {
        AuthenticationState authState =
            AuthenticationState.initialState('12345');
        expect(null, isNot(equals(authState.authPKCEState)));
        expect(null, authState.token);
      });
    });
  });
}
