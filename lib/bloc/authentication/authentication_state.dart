part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class NoToken extends AuthenticationState {}

class PreToken extends AuthenticationState{
  final PKCEToken token;

  PreToken(String clientId) : token = PKCEToken(clientId);
}

class SomeToken extends AuthenticationState {
  final Token token;

  SomeToken(this.token);
}

