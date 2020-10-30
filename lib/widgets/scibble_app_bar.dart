import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:scibble/redux/store.dart';
import 'package:scibble/redux/user/actions.dart';
import 'package:scibble/theme/scibble_color.dart';

class ScibbleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  @override
  final Size preferredSize;

  ScibbleAppBar({this.title}) : preferredSize = Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ScibbleAppBarViewModel>(
      converter: (store) => _ScibbleAppBarViewModel(
        logout: () => logoutUser(store),
        isLoggedIn: store.state.user != null,
      ),
      builder: (_, vm) => ScibbleAppBarViewModel(vm, title),
    );
  }
}

class ScibbleAppBarViewModel extends StatelessWidget {
  final _ScibbleAppBarViewModel _vm;
  final String title;
  ScibbleAppBarViewModel(this._vm, this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title ?? ''),
      backgroundColor: ScibbleColor.onlineBlue,
      actions: _vm.isLoggedIn
          ? [IconButton(icon: Icon(Icons.logout), onPressed: _vm.logout)]
          : null,
    );
  }
}

class _ScibbleAppBarViewModel {
  void Function() logout;
  bool isLoggedIn;
  _ScibbleAppBarViewModel({this.logout, this.isLoggedIn});
}
