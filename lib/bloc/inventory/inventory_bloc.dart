import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scibble/bloc/authentication/authentication_bloc.dart';
import 'package:scibble/models/online_web/product.dart';
import 'package:http/http.dart' as http;

export 'package:bloc/bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final AuthenticationBloc authBloc;

  InventoryBloc(this.authBloc) : super(EmptyInventory()) {
    on<GetInventory>((event, emit) async {
      final token = (authBloc.state as SomeToken).token;
      http.Response response = await http.get(
        Uri.parse('https://online.ntnu.no/api/v1/inventory/'),
        headers: {'Authorization': 'Bearer ${token.accessToken}'},
      );

      print(response.body);

      final List jsonArray = json.decode(Utf8Decoder().convert(response.bodyBytes));
      final List<Product> inventory =
          jsonArray.map((product) => Product.fromJson(product)).toList();
      return emit(SomeInventory(inventory));
    });

    on<PushInventory>((event, emit) {
      // TODO: Implement push inventory
      print('IMPLEMENT PUSH INVENTORY');
    });
  }
}
