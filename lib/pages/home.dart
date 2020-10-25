import 'package:flutter/material.dart';

import 'package:scibble/pages/barcode.dart';
import 'package:scibble/pages/inventory.dart';
import 'package:scibble/theme/scibble_color.dart';
import 'package:scibble/widgets/hamburger.dart';
import 'package:scibble/widgets/scibble_app_bar.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewModel();
}

class _HomeViewModel extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _content = [Inventory(), Barcode()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScibbleAppBar(),
      drawer: HamburgerMenu(),
      body: _content[_selectedIndex],
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
  }
}
