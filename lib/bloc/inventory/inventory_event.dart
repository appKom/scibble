part of 'inventory_bloc.dart';

@immutable
abstract class InventoryEvent {}

class GetInventory extends InventoryEvent {}
class PushInventory extends InventoryEvent {}