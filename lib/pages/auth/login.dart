import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import 'package:scibble/redux/authentication/actions.dart';
import 'package:scibble/redux/store.dart';
import 'package:scibble/theme/scibble_color.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        onDidChange: (store) {
          final state = store.state.auth;
          if (state.tokenState.token != null && state.userState.user == null) {
            getUserProfile(store);
          }
        },
        builder: (context, store) {
          final token = store.state.auth.tokenState.token;
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
                token == null ? LoginButton() : CircularProgressIndicator(),
                Spacer(flex: 1),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  LoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        return (FlatButton(
          color: ScibbleColor.onlineBlue,
          textColor: Colors.white,
          splashColor: ScibbleColor.onlineOrange,
          padding: EdgeInsets.all(15.0),
          onPressed: () {
            if (store.state.auth.authPKCEState.pkce.code == null) {
              store.dispatch(NavigateToAction.push('/login/online'));
            }
            return null;
          },
          child: Container(
            width: 260,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/Online_hvit_o.png',
                  height: 30,
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  'Logg in gjennom Online',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
