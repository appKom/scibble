import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:scibble/widgets/scibble_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:scibble/models/auth_pkce.dart';
import 'package:scibble/redux/authentication/actions.dart';
import 'package:scibble/redux/store.dart';

class OnlineLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScibbleAppBar(title: "Logg inn"),
      body: StoreConnector<AppState, _OnlineLoginViewModel>(
        converter: (store) => _OnlineLoginViewModel(
          pkce: store.state.auth.authPKCEState.pkce,
          tradeCodeForToken: (code) {
            store.dispatch(SetCode(code));
            tradeCodeForToken(store);
            store.dispatch(NavigateToAction.pop());
          },
        ),
        builder: (_, vm) => OnlineLoginViewModel(vm: vm),
      ),
    );
  }
}

class OnlineLoginViewModel extends StatefulWidget {
  final _OnlineLoginViewModel vm;
  OnlineLoginViewModel({Key key, this.vm}) : super(key: key);

  @override
  _OnlineWebLoginState createState() => _OnlineWebLoginState(vm);
}

class _OnlineWebLoginState extends State<OnlineLoginViewModel> {
  final _OnlineLoginViewModel vm;
  bool _isLoading = true;

  _OnlineWebLoginState(this.vm);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final spinnerWidget =
        _isLoading ? Center(child: CircularProgressIndicator()) : Stack();
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
        spinnerWidget,
      ],
    );
  }
}

class _OnlineLoginViewModel {
  AuthPKCE pkce;
  void Function(String) tradeCodeForToken;

  _OnlineLoginViewModel({this.pkce, this.tradeCodeForToken});
}
