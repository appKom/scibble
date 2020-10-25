import 'package:scibble/models/product.dart';
import 'package:scibble/redux/inventory/actions.dart';

List<Product> inventoryReducer(List<Product> prevState, dynamic action) {
  if (action is SetInventory)
    return action.payload;
  return prevState;

}