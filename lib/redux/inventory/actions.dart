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
  final token = store.state.auth.tokenState.token;
  var response = await http.get(
    'https://online.ntnu.no/api/v1/inventory/',
    headers: {'Authorization': 'Bearer ${token.accessToken}'},
  );
  List jsonArray = json.decode(response.body);
  List<Product> inventory = jsonArray.map((product) => Product.fromJson(product));
  await store.dispatch(SetInventory(inventory));
};