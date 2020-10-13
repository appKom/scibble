import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

import 'package:scibble/redux/store.dart';
import 'package:scibble/widgets/hamburger.dart';
import 'package:scibble/widgets/scibble_app_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScibbleAppBar(),
      drawer: HamburgerMenu(),
      body: HomeViewModel(),
    );
  }
}

class HomeViewModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('This is home'),
      ],
    );
  }
}
