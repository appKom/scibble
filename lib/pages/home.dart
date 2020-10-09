import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:scibble/redux/store.dart';
import 'package:scibble/widgets/hamburger.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Scibble'),
            ),
            body: Column(
              children: [
                Text('Last name: ${store.state.auth.userState.user.lastName}'),
                Text(
                    'Acess token: ${store.state.auth.tokenState.token.accessToken}'),
              ],
            ),
            drawer: HamburgerMenu(),
          );
        },
      ),
    );
  }
}
