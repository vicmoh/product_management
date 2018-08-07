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
  String _title = '';
  String _description = '';
  double _price = 0.0;

  // popup modal from bottom
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

  // textfield
  Widget _buildTextField(String title, int numOfLines, TextInputType type, Function setter) {
    return TextField(keyboardType: type,
        maxLines: numOfLines,
        decoration: InputDecoration(labelText: title),
        onChanged: (dynamic value) {
          setState(() {
            setter(value);
          });
        });
  } //end build

  // subtmit map form
  void _submitForm() {
    final Map<String, dynamic> product = {
      "title": this._title,
      "description": this._description,
      "price": this._price,
      "image": 'assets/food.jpg'
    };
    print("---ADDING---");
    print("Title: " + this._title);
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(15.0),
        child: Column(children: <Widget>[
          // title
          _buildTextField("Product Title", 1, TextInputType.text, (String value){
            this._title = value;
          }),
          // description
          _buildTextField("Product Description", 4, TextInputType.text, (String value){
            this._description = value;
          }),
          // price
          _buildTextField("Product Price", 1, TextInputType.number, (String value){
            this._price = double.parse(value);
          }),

          // save button
          Container(
              padding: EdgeInsets.only(top: 15.0),
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  child: Text("Save"),
                  onPressed: _submitForm)),
        ]));
  }
}
