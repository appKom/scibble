import 'package:scibble/models/token.dart';
import 'package:scibble/redux/authentication/actions.dart';
import 'package:scibble/redux/authentication/state.dart';

AuthenticationState authenticationReducer(
    AuthenticationState state, dynamic action) {
  return new AuthenticationState(
    token: tokenReducer(state.token, action),
    authPKCEState: authPKCEReducer(state.authPKCEState, action),
  );
}

Token tokenReducer(Token prevState, dynamic action) {
  if (action is SetToken) {
    return action.payload;
  }
  return prevState;
}

AuthPKCEState authPKCEReducer(AuthPKCEState prevState, dynamic action) {
  if (action is SetAuthPKCE) {
    return new AuthPKCEState(pkce: action.payload);
  }
  return prevState;
}
