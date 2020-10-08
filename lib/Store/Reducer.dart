import 'package:scibble/Store/Actions.dart';
import 'package:scibble/Store/AppState.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is SetAuthentication) {
    newState.auth = action.payload;
  } else if (action is SetToken) {
    newState.token = action.payload;
  } else if (action is SetUser) {
    newState.user = action.payload;
  }

  return newState;
}
