part of 'inventory_bloc.dart';

@immutable
abstract class InventoryState {}

class EmptyInventory extends InventoryState {}

class SomeInventory extends InventoryState {
  final List<Product> inventory;

  SomeInventory(this.inventory);
}