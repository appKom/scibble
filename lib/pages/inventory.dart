import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scibble/models/product.dart';
import 'package:scibble/redux/inventory/actions.dart';
import 'package:scibble/redux/store.dart';
import 'package:scibble/theme/scibble_color.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _InventoryViewModel>(
      converter: (store) => _InventoryViewModel(store.state.inventory,
          getInventory: store.dispatch(getInventory(store))),
      builder: (_, viewModel) => InventoryViewModel(
        viewModel: viewModel,
      ),
      rebuildOnChange: false,
    );
  }
}

class InventoryViewModel extends StatelessWidget {
  final _InventoryViewModel viewModel;

  InventoryViewModel({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: viewModel.inventory.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          height: 100,
          color: ScibbleColor.onlineBlue,
          child: InventoryListTile(viewModel.inventory[index]),
        );
      },
    );
  }
}

class _InventoryViewModel {
  final List<Product> _inventory;
  List<Product> get inventory => this._inventory;

  void Function() getInventory;

  _InventoryViewModel(this._inventory, {this.getInventory});
}

class InventoryListTile extends StatelessWidget {
  final Product _product;

  InventoryListTile(this._product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      leading: Image.network("https://online.ntnu.no/" + _product.image.sm),
      title: Text(
        _product.name,
        style: TextStyle(color: ScibbleColor.onlineOrange),
      ),
      trailing: Text(
        _product.price.toString() + " kr",
        style: TextStyle(color: ScibbleColor.onlineOrange),
      ),
    );
  }
}
