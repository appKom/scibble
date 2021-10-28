import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scibble/app_router.dart';
import 'package:scibble/bloc/authentication/authentication_bloc.dart';
import 'package:scibble/bloc/inventory/inventory_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/authentication/token.dart';

late final SharedPreferences prefs;
late final AuthenticationBloc authBloc;

void main() async {
  // Necessary to wait for config retrieval
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");

  initializeAuthenticationBloc();
  setPreviousTokenIfStillValid();
  runApp(Scibble());
}

void initializeAuthenticationBloc() {
  final _clientId = prefs.getString('client_id') ?? dotenv.env["CLIENT_ID"]!;
  authBloc = AuthenticationBloc(clientId: _clientId, prefs: prefs);
}

void setPreviousTokenIfStillValid() {
  final _prevToken = Token.fromJson(json.decode(prefs.getString('token') ?? '{}'));
  if (_prevToken.expiresAt?.isBefore(DateTime.now()) ?? false) {
    authBloc.add(SetToken(token: _prevToken));
  }
}

class Scibble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authBloc),
        BlocProvider(create: (_) => InventoryBloc(authBloc))
      ],
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
