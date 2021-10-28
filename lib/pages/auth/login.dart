import 'package:flutter/material.dart';
import 'package:scibble/bloc/authentication/authentication_bloc.dart';

import 'package:scibble/widgets/online_login_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    if (authBloc.state is SomeToken)
      Future.microtask(() => Navigator.pushNamed(context, '/home'));

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 1),
            Text(
              'Scibble',
              style: TextStyle(
                fontSize: 50,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(flex: 1),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              if (state is SomeToken) {}
              return (state is SomeToken)
                  ? CircularProgressIndicator()
                  : LoginButton(goToLoginView: () {
                      authBloc.add(MakePreToken());
                      Navigator.pushNamed(context, '/login/online');
                    });
            }),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
