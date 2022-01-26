import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scibble/bloc/inventory/inventory_bloc.dart';
import 'package:scibble/models/online_web/product.dart';
import 'package:scibble/theme/scibble_color.dart';

class InventoryPage extends StatelessWidget {
  InventoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        if (state is EmptyInventory) {
          BlocProvider.of<InventoryBloc>(context).add(GetInventory());
          return Center(child: CircularProgressIndicator());
        } else if (state is SomeInventory)
          return InventoryPageContent(state.inventory);
        else
          return Center(child: ErrorWidget("Cannot handle bloc state"));
      },
    );
  }
}

class InventoryPageContent extends StatelessWidget {
  final List<Product> inventory;

  InventoryPageContent(this.inventory);

  void refreshInventory(context) {}

  @override
  Widget build(BuildContext context) {
    return inventory.length > 0
        ? RefreshIndicator(
            child: ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: inventory.length,
              itemBuilder: (BuildContext context, int index) {
                return InventoryListTile(inventory[index]);
              },
            ),
            onRefresh: () async =>
                BlocProvider.of<InventoryBloc>(context).add(GetInventory()),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('No products available'),
                OutlinedButton(
                  onPressed: () => BlocProvider.of<InventoryBloc>(context)
                      .add(GetInventory()),
                  child: Text("Refresh"),
                ),
              ],
            ),
          );
  }
}

class InventoryListTile extends StatelessWidget {
  final Product _product;

  InventoryListTile(this._product);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      leading: InventoryImage(product: _product),
      title: Text(
        _product.name ?? '',
        style: TextStyle(color: ScibbleColor.onlineOrange),
      ),
      subtitle: Text(
        _product.category?.name ?? '',
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        "id: " + _product.pk.toString(),
        style: TextStyle(color: Colors.grey),
      ),
      tileColor: ScibbleColor.onlineBlue,
    ));
  }
}

class InventoryImage extends StatelessWidget {
  final Product product;
  const InventoryImage({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('https://online.ntnu.no/');
    print(product.image?.xs);
    print(product.image?.sm);
    print(product.image?.md);
    print(product.image?.lg);

    //TODO: This was changed during OW cloud migration.
    //      Might not work in the future.
    return product.image != null
        ? Image.network(
          // product.image?.xs
            // "https://online.ntnu.no/" +
                (product.image?.xs ??
                    product.image?.sm ??
                    product.image?.md ??
                    product.image?.lg ??
                    ""),
            errorBuilder: (context, a, stack) {
              return ErrorWidget("Oops");
            },
          )
        : Icon(
            Icons.inventory,
            color: ScibbleColor.onlineOrange,
          );
  }
}
