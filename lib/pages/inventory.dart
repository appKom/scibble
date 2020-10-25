import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scibble/models/product.dart';
import 'package:scibble/redux/inventory/actions.dart';
import 'package:scibble/redux/store.dart';
import 'package:scibble/theme/scibble_color.dart';
import 'package:scibble/widgets/hamburger.dart';
import 'package:scibble/widgets/scibble_app_bar.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ScibbleAppBar(),
        drawer: HamburgerMenu(),
        body: StoreConnector<AppState, _InventoryViewModel>(
          converter: (store) => _InventoryViewModel(store.state.inventory,
              getInventory: store.dispatch(getInventory(store))),
          builder: (_, viewModel) => InventoryViewModel(),
          onInit: (store) => store.dispatch(getInventory(store)),
        ));
  }
}

class InventoryViewModel extends StatelessWidget {
  final _InventoryViewModel viewModel;

  InventoryViewModel({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: viewModel._inventory.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(0),
          height: 100,
          color: ScibbleColor.onlineBlue,
          child: InventoryListTile(viewModel._inventory[index]),
        );
      },
    );
  }
}

class _InventoryViewModel {
  final List<Product> _inventory;
  List<Product> get inventory => this.inventory;

  void Function() getInventory;

  _InventoryViewModel(this._inventory, {this.getInventory});
}

class InventoryListTile extends StatelessWidget {
  final Product _product;

  InventoryListTile(this._product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading:
            Image.network("https://online.ntnu.no/api/v1/" + _product.image.sm),
        title: Text(_product.name),
        trailing: Text(_product.pk.toString()));
  }
}
