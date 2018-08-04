import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;
  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue = '';
  String descriptionValue = '';
  double priceValue = 0.0;

  _modalShowCase(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text("save"),

          // sliding modal from bottom
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Center(child: Text("This is Modal!"));
                });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(15.0),
        child: Column(children: <Widget>[
          // title
          TextField(
              decoration: InputDecoration(labelText: "Product Title"),
              onChanged: (String value) {
                setState(() {
                  this.titleValue = value;
                });
              }),

          // description
          TextField(
              maxLines: 4,
              decoration: InputDecoration(labelText: "Product Description"),
              onChanged: (String value) {
                setState(() {
                  this.descriptionValue = value;
                });
              }),

          // price
          TextField(
              decoration: InputDecoration(labelText: "Product Price"),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  this.priceValue = double.parse(value);
                });
              }),

          RaisedButton(
              child: Text("Save"),
              onPressed: () {
                final Map<String, dynamic> product = {
                  "title": this.titleValue,
                  "description": this.descriptionValue,
                  "price": this.priceValue,
                  "image": 'assets/food.jpg'
                };
                widget.addProduct(product);
              }),
              
        ]));
  }
}
