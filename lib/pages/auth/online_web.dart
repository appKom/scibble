import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:scibble/widgets/scibble_app_bar.dart';
import 'package:scibble/models/auth_pkce.dart';
import 'package:scibble/redux/authentication/actions.dart';
import 'package:scibble/redux/store.dart';

class OnlineWeb extends StatefulWidget {
  OnlineWeb({Key key}) : super(key: key);

  @override
  _OnlineWebState createState() => _OnlineWebState();
}

class _OnlineWebState extends State<OnlineWeb> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScibbleAppBar(),
      body: StoreConnector<AppState, _OnlineWebViewModel>(
        converter: (store) => _OnlineWebViewModel(
          pkce: store.state.auth.authPKCEState.pkce,
          tradeCodeForToken: (code) {
            store.state.auth.authPKCEState.pkce.code = code;
            tradeCodeForToken(store);
            store.dispatch(NavigateToAction.pop());
          },
        ),
        builder: (context, vm) {
          return Stack(
            children: [
              WebView(
                initialUrl: vm.pkce.authenticateUrl,
                onPageFinished: (url) => setState(() => _isLoading = false),
                navigationDelegate: (NavigationRequest request) {
                  Uri responseUri = Uri.parse(request.url);
                  String code = responseUri.queryParameters['code'];
                  if (code != null) {
                    vm.tradeCodeForToken(code);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
              _isLoading ? Center(child: CircularProgressIndicator()) : Stack(),
            ],
          );
        },
      ),
    );
  }
}

class _OnlineWebViewModel {
  AuthPKCE pkce;
  void Function(String) tradeCodeForToken;

  _OnlineWebViewModel({this.pkce, this.tradeCodeForToken});
}
