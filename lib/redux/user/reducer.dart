import 'package:scibble/models/user.dart';
import 'package:scibble/redux/user/actions.dart';

User userReducer(User prevState, dynamic action) {
  if (action is SetUser) {
    return action.payload;
  }
  return prevState;
}
