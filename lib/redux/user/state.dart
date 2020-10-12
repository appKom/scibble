import 'package:flutter/material.dart';

import 'package:scibble/models/user.dart';

@immutable
class UserState {
  final User user;
  const UserState({@required this.user});
}
