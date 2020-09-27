import 'package:flutter/material.dart';

import 'package:global_configuration/global_configuration.dart';

import 'package:scibble/OnlineWeb/Authentication.dart';
import 'package:scibble/OnlineWeb/Token.dart';
import 'package:scibble/OnlineWeb/User.dart';
import 'package:scibble/Page/home.dart';
import 'package:scibble/Theme/ScibbleColor.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String clientId = GlobalConfiguration().get('client_id');
  Authentication _authentication;
  Token _token;
  User _user;

  void getToken() async {
    var code = _authentication.authorizationCode();
    if (code != null) {
      var token = await _authentication.tradeCodeForToken(code);
      setState(() {
        _token = token;
      });
    }
  }

  void getUser() async {
    var user = await _authentication.userInfo(_token.accessToken);
    setState(() {
      _user = user;
    });
  }

  // Need navigate to next screen after build, else the navigator will
  // throw an error for half a second
  void afterBuild() {
    if (_user != null && _token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(user: _user, token: _token),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());
    _authentication = Authentication(clientId);
    if (_token == null) {
      getToken();
    }
    if (_token != null && _user == null) {
      getUser();
    }

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
            _token == null
                ? LoginButton(authentication: _authentication)
                : CircularProgressIndicator(),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  LoginButton({Key key, this.authentication}) : super(key: key);

  final Authentication authentication;

  @override
  Widget build(BuildContext context) {
    return (FlatButton(
      color: ScibbleColor.onlineBlue,
      textColor: Colors.white,
      splashColor: ScibbleColor.onlineOrange,
      padding: EdgeInsets.all(15.0),
      onPressed: () {
        authentication.authenticate();
      },
      child: Container(
        width: 260,
        child: Row(
          children: [
            Image.asset(
              'images/Online_hvit_o.png',
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
  }
}
