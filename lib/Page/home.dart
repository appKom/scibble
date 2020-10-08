import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:scibble/Store/AppState.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          print('building home');
          return Column(
            children: [
              Text('Last name: ${store.state.user.lastName}'),
              Text('Acess token: ${store.state.token.accessToken}'),
            ],
          );
        },
      ),
    );
  }
}
