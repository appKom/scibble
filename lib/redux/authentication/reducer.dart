import 'package:scibble/redux/authentication/actions.dart';
import 'package:scibble/redux/authentication/state.dart';

AuthenticationState authenticationReducer(
        AuthenticationState state, dynamic action) =>
    new AuthenticationState(
      userState: userReducer(state.userState, action),
      tokenState: tokenReducer(state.tokenState, action),
      authPKCEState: authPKCEReducer(state.authPKCEState, action),
    );

UserState userReducer(UserState prevState, dynamic action) {
  if (action is SetUser) {
    return new UserState(user: action.payload);
  }
  return prevState;
}

TokenState tokenReducer(TokenState prevState, dynamic action) {
  if (action is SetToken) {
    return new TokenState(token: action.payload);
  }
  return prevState;
}

AuthPKCEState authPKCEReducer(AuthPKCEState prevState, dynamic action) {
  if (action is SetAuthPKCE) {
    return new AuthPKCEState(pkce: action.payload);
  }
  return prevState;
}
