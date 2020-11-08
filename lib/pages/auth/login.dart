import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:scibble/models/token.dart';

import 'package:scibble/redux/store.dart';
import 'package:scibble/redux/user/actions.dart';
import 'package:scibble/widgets/online_login_button.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _LoginViewModel>(
        converter: (store) => _LoginViewModel(
          token: store.state.auth.token,
          code: store.state.auth.authPKCEState.code,
          getProfile: () {
            final state = store.state;
            if (state.auth.token != null && state.user == null) {
              getUserProfile(store);
            }
          },
          goToLoginView: () =>
              store.dispatch(NavigateToAction.push('/login/online')),
        ),
        onDidChange: (vm) => vm.getProfile(),
        builder: (_, vm) => LoginViewModel(vm: vm),
      ),
    );
  }
}

class LoginViewModel extends StatelessWidget {
  final _LoginViewModel vm;
  LoginViewModel({Key key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
          vm.token == null
              ? LoginButton(
                  code: vm.code,
                  goToLoginView: vm.goToLoginView,
                )
              : CircularProgressIndicator(),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class _LoginViewModel {
  final Token token;
  final String code;
  void Function() getProfile;
  void Function() goToLoginView;
  _LoginViewModel({
    this.token,
    this.code,
    this.getProfile,
    this.goToLoginView,
  });
}
