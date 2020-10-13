import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

import 'package:scibble/redux/store.dart';
import 'package:scibble/widgets/hamburger.dart';
import 'package:scibble/widgets/scibble_app_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScibbleAppBar(),
        drawer: HamburgerMenu(),
        body: StoreConnector<AppState, _HomeViewModel>(
          converter: (store) => _HomeViewModel(
              append: () => store.dispatch(NavigateToAction.push('/home'))),
          builder: (_, vm) => HomeViewModel(vm),
        ));
  }
}

class HomeViewModel extends StatelessWidget {
  HomeViewModel(this._vm);
  final _HomeViewModel _vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(onPressed: _vm.append, child: Text('Press me')),
      ],
    );
  }
}

class _HomeViewModel {
  void Function() append;
  _HomeViewModel({this.append});
}
