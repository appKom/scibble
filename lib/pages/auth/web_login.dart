import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scibble/bloc/authentication/authentication_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlineLoginPage extends StatefulWidget {
  OnlineLoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _OnlinePageState createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlineLoginPage> {
  bool _isLoading = true;

  _OnlinePageState();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final spinnerWidget =
        _isLoading ? Center(child: CircularProgressIndicator()) : Stack();

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is SomeToken)
          Navigator.popAndPushNamed(context, '/home');
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Logg inn')),
        body: Stack(
          children: [
            WebView(
              initialUrl: (authBloc.state as PreToken).token.authenticateUrl,
              onPageFinished: (_) => setState(() => _isLoading = false),
              navigationDelegate: (NavigationRequest request) async {
                Uri responseUri = Uri.parse(request.url);
                String? code = responseUri.queryParameters['code'];
                if (code != null) {
                  authBloc.add(
                    GetToken(
                      code: code,
                      pkceToken: (authBloc.state as PreToken).token,
                    ),
                  );
                  setState(() => _isLoading = true);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
            spinnerWidget,
          ],
        ),
      ),
    );
  }
}
