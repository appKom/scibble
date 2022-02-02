import 'package:flutter/material.dart';

class InvalidRoute extends StatelessWidget {
  const InvalidRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This route is invalid. Please report this incident to Appkom'),
      ),
    );
  }
}
