import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scibble/models/product.dart';
import 'package:scibble/theme/scibble_color.dart';
import 'package:scibble/widgets/button.dart';
import 'package:scibble/widgets/input_text_field.dart';
import 'package:scibble/widgets/scibble_app_bar.dart';

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
  bool forSale = false;

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
      appBar: ScibbleAppBar(title: product.name),
      body: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(children: [
                Row(children: [
                  Button(onPress: edit, child: Text(editing ? "Save changes" : "Edit")),
                  editing
                      ? Button(
                          onPress: toggleEditing,
                          child: Text("Cancel"),
                        )
                      : Container(),
                ]),
                CheckboxListTile(
                  title: Text("Til salgs"),
                  value: forSale,
                  onChanged: editing ? (state) => setState(() => forSale = !forSale) : null,
                  activeColor: Colors.transparent,
                  checkColor: ScibbleColor.onlineOrange,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                InputTextField(
                  label: 'Varenavn',
                  input: editProduct.name,
                  setInput: setName,
                  enabled: editing,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey[350]),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Image.network(
                              "https://online.ntnu.no/media/images/responsive/sm/290322e5-ea92-4ed2-8a5b-ee1ea1596b7c.png"),
                        ),
                        Column(
                          children: [
                            Button(child: Text("Velg")),
                            Button(child: Text("Last opp")),
                            Button(child: Text("Fjern")),
                          ],
                        )
                      ],
                    )),
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
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
