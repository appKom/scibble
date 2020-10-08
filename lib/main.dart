import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:scibble/Page/home.dart';
import 'package:scibble/Page/login.dart';
import 'package:scibble/Page/onlineView.dart';
import 'package:scibble/Store/AppState.dart';
import 'package:scibble/Store/Reducer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('app_settings');
  final _clientId = GlobalConfiguration().get('client_id');
  final _initalState = AppState(_clientId);
  // Necessary to wait for config retrieval
  final Store<AppState> _store = Store<AppState>(
    reducer,
    initialState: _initalState,
    middleware: [
      thunkMiddleware,
      NavigationMiddleware<AppState>(),
    ],
  );
  runApp(Scibble(store: _store));
}

class Scibble extends StatelessWidget {
  final Store<AppState> store;

  Scibble({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        navigatorKey: NavigatorHolder.navigatorKey,
        routes: {
          '/': (context) => Login(),
          '/login/online': (context) => OnlineView(),
          '/home': (context) => Home(),
        },
      ),
    );
  }
}
