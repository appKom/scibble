import 'package:flutter/material.dart';
import 'package:scibble/bloc/authentication/authentication_bloc.dart';

class LogoutListener extends StatelessWidget {
  final Widget child;

  const LogoutListener({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is NoToken)
          Navigator.popAndPushNamed(context, '/');
      },
      child: child
    );
  }
}
