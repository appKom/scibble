import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:scibble/Store/Actions.dart';
import 'package:scibble/Store/AppState.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlineView extends StatefulWidget {
  OnlineView({Key key}) : super(key: key);

  @override
  _OnlineViewState createState() => _OnlineViewState();
}

class _OnlineViewState extends State<OnlineView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return WebView(
            initialUrl: store.state.auth.authenticateUrl,
            navigationDelegate: (NavigationRequest request) {
              Uri responseUri = Uri.parse(request.url);
              String code = responseUri.queryParameters['code'];
              if (code != null) {
                store.state.auth.code = code;
                tradeCodeForToken(store);
                store.dispatch(NavigateToAction.pop());
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          );
        },
      ),
    );
  }
}
