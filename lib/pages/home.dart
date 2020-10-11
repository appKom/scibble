import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:scibble/redux/store.dart';
import 'package:scibble/theme/scibble_color.dart';
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
              title: Text('Sidetittel'),
              backgroundColor: ScibbleColor.onlineOrange,
              actions: [
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () => logoutUser(store))
              ],
            ),
            body: Column(
              children: [
                Text(
                    'Last name: ${store.state.auth.userState.user.toJson() ?? 'no user'}'),
              ],
            ),
            drawer: HamburgerMenu(),
          );
        },
      ),
    );
  }
}
