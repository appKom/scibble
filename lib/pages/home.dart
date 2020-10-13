import 'package:flutter/material.dart';

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
