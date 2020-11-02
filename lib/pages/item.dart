import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scibble/models/product.dart';
import 'package:scibble/widgets/button.dart';
import 'package:scibble/widgets/input_text_field.dart';

class ItemView extends StatefulWidget {
  final Product product;
  ItemView({@required this.product});
  @override
  _ItemView createState() => _ItemView(this.product);
}

class _ItemView extends State<ItemView> {
  Product product;
  Product editProduct;
  bool editing = false;

  _ItemView(this.product) {
    editProduct = new Product.copy(product);
  }

  setName(String value) => editProduct.name = value;
  setDescription(String value) => editProduct.description = value;
  setCategory(String value) => editProduct.category.name = value;
  setPrice(String value) => editProduct.price = int.parse(value);
  toggleEditing() => setState(() => editing = !editing);

  edit() {
    if (editing) {
      saveChanges();
    }
    toggleEditing();
  }

  saveChanges() => setState(() => product = editProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(product.name),
            Row(children: [
              Button(
                  onPress: edit,
                  child: Text(editing ? "Save changes" : "Edit")),
              editing
                  ? Button(
                      onPress: toggleEditing,
                      child: Text("Cancel"),
                    )
                  : Container()
            ]),
            InputTextField(
              label: 'Varenavn',
              input: editProduct.name,
              setInput: setName,
              enabled: editing,
            ),
            InputTextField(
              label: 'Pris',
              input: product.price.toString(),
              setInput: setPrice,
              suffix: "kr",
              keyboardType: TextInputType.number,
              enabled: editing,
            ),
            InputTextField(
              label: 'Beskrivelse',
              input: product.description,
              setInput: setDescription,
              enabled: editing,
            ),
            InputTextField(
              label: 'Kategori',
              input: product.category.name,
              setInput: setDescription,
              enabled: editing,
            ),
          ],
        ),
      ),
    );
  }
}
