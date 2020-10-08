import 'package:scibble/OnlineWeb/Authentication.dart';
import 'package:scibble/OnlineWeb/Token.dart';
import 'package:scibble/OnlineWeb/User.dart';

class AppState {
  Authentication auth;
  Token token;
  User user;

  AppState(String _clientId) {
    auth = new Authentication(_clientId);
  }

  AppState.fromAppState(AppState another) {
    auth = another.auth;
    token = another.token;
    user = another.user;
  }
}
