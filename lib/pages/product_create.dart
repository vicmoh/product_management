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
  String _titleValue = '';
  String _descriptionValue = '';
  double _priceValue = 0.0;

  // _modalShowCase(BuildContext context) {
  //   return Center(
  //     child: RaisedButton(
  //         child: Text("save"),

  //         // sliding modal from bottom
  //         onPressed: () {
  //           showModalBottomSheet(
  //               context: context,
  //               builder: (BuildContext context) {
  //                 return Center(child: Text("This is Modal!"));
  //               });
  //         }),
  //   );
  // }

  Widget _buildTextField(String title, dynamic thisValue, int numOfLines) {
    return TextField(
        maxLines: numOfLines,
        decoration: InputDecoration(labelText: title),
        onChanged: (String value) {
          setState(() {
            thisValue = value;
          });
        });
  } //end build title

  _submitForm() {
    final Map<String, dynamic> product = {
      "title": this._titleValue,
      "description": this._descriptionValue,
      "price": this._priceValue,
      "image": 'assets/food.jpg'
    };
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
          _buildTextField("Product Title", this._titleValue, 1),
          // description
          _buildTextField("Product Description", this._descriptionValue, 4),
          // price
          _buildTextField("Product Price", this._priceValue, 1),

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
