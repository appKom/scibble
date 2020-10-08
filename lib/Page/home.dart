import 'package:flutter/material.dart';
import 'package:scibble/Components/hamburger.dart';

import 'package:scibble/OnlineWeb/Token.dart';
import 'package:scibble/OnlineWeb/User.dart';

class Home extends StatefulWidget {
  Home({Key key, this.user, this.token}) : super(key: key);

  final User user;
  final Token token;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Scibble')),
      body: Column(
        children: [
          Text('Last name: ${widget.user.lastName}'),
          Text('Acess token: ${widget.token.accessToken}'),
        ],
      ),
      drawer: HamburgerMenu(),
    );
  }
}
