import 'package:flutter/foundation.dart';
import 'package:scibble/models/product.dart';

@immutable
class InventoryState {
  final List<Product> inventory;
  const InventoryState({@required this.inventory});
}