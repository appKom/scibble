import 'package:flutter_test/flutter_test.dart';

import 'package:scibble/models/product.dart';
import 'package:scibble/redux/inventory/actions.dart';
import 'package:scibble/redux/inventory/reducer.dart';

void main() {
  group('Inventory Redux', () {
    final List<Product> initialState = [];
    test('Set inventory test', () {
      final product1 = Product();
      final product2 = Product();
      final newState = inventoryReducer(initialState, SetInventory([product1, product2]));
      expect([product1, product2], newState);
    });
  });
}
