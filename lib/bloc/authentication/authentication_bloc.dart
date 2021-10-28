import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:scibble/bloc/authentication/unauthorized_exception.dart';
import 'dart:convert';
import 'package:scibble/models/authentication/pkce_token.dart';
import 'package:scibble/models/authentication/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:bloc/bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final String clientId;
  final SharedPreferences prefs;

  AuthenticationBloc({
    required this.clientId,
    required this.prefs,
  }) : super(NoToken()) {

    on<RemoveToken>((event, emit) async {
      await prefs.remove('token');
      emit(NoToken());
    });

    on<MakePreToken>((event, emit) {
      emit(PreToken(this.clientId));
    });

    on<GetToken>((event, emit) async {
      var response = await http.post(
        Uri.parse('https://online.ntnu.no/openid/token'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'authorization_code',
          'code': event.code,
          'redirect_uri': 'http://localhost:6969/#/',
          'client_id': event.pkceToken.clientId,
          'code_verifier': event.pkceToken.verifier,
        },
      );
      if (response.statusCode == 200) {
        Token token = Token.fromJson(json.decode(response.body));
        await prefs.setString('token', json.encode(token));
        emit(SomeToken(token));
      } else {
        throw UnauthorizedException("Could not fetch OAuth2 token.");
      }
    });

    on<SetToken>((event, emit) {
      emit(SomeToken(event.token));
    });

  }
}
