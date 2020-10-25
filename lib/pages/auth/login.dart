import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:scibble/models/token.dart';

import 'package:scibble/redux/store.dart';
import 'package:scibble/redux/user/actions.dart';
import 'package:scibble/redux/store.dart';
import 'package:scibble/widgets/button.dart';

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
                store.dispatch(NavigateToAction.push('/login/online'))),
        onDidChange: (vm) => vm.getProfile(),
        builder: (context, vm) => LoginViewModel(vm: vm),
      ),
    );
  }
}

class LoginViewModel extends StatefulWidget {
  final _LoginViewModel vm;
  LoginViewModel({Key key, this.vm}) : super(key: key);

  @override
  _LoginState createState() => _LoginState(vm);
}

class _LoginState extends State<LoginViewModel> {
  final _LoginViewModel vm;
  _LoginState(this.vm);

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

class LoginButton extends StatelessWidget {
  final String code;
  final void Function() goToLoginView;
  LoginButton({Key key, this.code, this.goToLoginView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      onPress: code == null ? goToLoginView : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/Online_hvit_o.png',
            height: 30,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Logg inn gjennom Online',
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
