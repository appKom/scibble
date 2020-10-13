import 'package:flutter/material.dart';
import 'package:scibble/models/auth_pkce.dart';
import 'package:scibble/models/token.dart';

@immutable
class AuthPKCEState {
  final AuthPKCE pkce;
  const AuthPKCEState({@required this.pkce});
}

class AuthenticationState {
  final AuthPKCEState authPKCEState;
  final Token token;

  AuthenticationState({
    this.authPKCEState,
    this.token,
  });

  factory AuthenticationState.initialState(String clientId) =>
      AuthenticationState(
        authPKCEState: new AuthPKCEState(pkce: new AuthPKCE(clientId)),
        token: null,
      );
}
