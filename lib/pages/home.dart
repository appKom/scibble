import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scibble/bloc/authentication/authentication_bloc.dart';

import 'package:scibble/pages/barcode.dart';
import 'package:scibble/pages/inventory.dart';
import 'package:scibble/theme/scibble_color.dart';
import 'package:scibble/widgets/LogoutListener.dart';
import 'package:scibble/widgets/hamburger.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _content = [InventoryPage(), Barcode()];

  @override
  Widget build(BuildContext context) {
    return LogoutListener(
      child: Scaffold(
        // appBar: ScibbleAppBar(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(RemoveToken()),
            )
          ],
        ),
        drawer: HamburgerMenu(),
        body: _content[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: (index) => setState(() => _selectedIndex = index),
          currentIndex: _selectedIndex,
          selectedItemColor: ScibbleColor.onlineOrange,
          unselectedItemColor: Colors.black,
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
      ),
    );
  }
}
