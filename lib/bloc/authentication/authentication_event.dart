part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class RemoveToken extends AuthenticationEvent {}

class MakePreToken extends AuthenticationEvent {}

class GetToken extends AuthenticationEvent {
  final String code;
  final PKCEToken pkceToken;

  GetToken({
    required this.code,
    required this.pkceToken,
  });
}

class SetToken extends AuthenticationEvent {
  final Token token;

  SetToken({required this.token});
}
