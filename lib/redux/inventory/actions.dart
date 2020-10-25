import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'package:scibble/models/product.dart';

import '../store.dart';

class SetInventory {
  final List<Product> payload;
  SetInventory(this.payload);
}

ThunkAction<AppState> getInventory = (Store<AppState> store) async {
  final token = store.state.auth.token;
  var response = await http.get(
    'https://online.ntnu.no/api/v1/inventory/',
    headers: {'Authorization': 'Bearer ${token.accessToken}'},
  );
  final List jsonArray = json.decode(response.body);
  final List<Product> inventory =
      jsonArray.map((product) => Product.fromJson(product)).toList();
  await store.dispatch(SetInventory(inventory));
};
