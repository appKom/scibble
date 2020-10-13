import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:scibble/pages/barcode.dart';
import 'package:scibble/pages/inventory.dart';

import 'package:scibble/redux/store.dart';
import 'package:scibble/redux/user/actions.dart';
import 'package:scibble/theme/scibble_color.dart';
import 'package:scibble/widgets/hamburger.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _content = [Inventory(), Barcode()];

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
            body: _content[_selectedIndex],
            drawer: HamburgerMenu(),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: ScibbleColor.onlineBlue,
              onTap: (index) => setState(() => _selectedIndex = index),
              currentIndex: _selectedIndex,
              selectedItemColor: ScibbleColor.onlineOrange,
              unselectedItemColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.list_alt_outlined),
                  label: 'Inventar',
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.qr_code_scanner_outlined),
                  label: 'Strekkode',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
