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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
  } //end modal func

  _setTitle(String value) {
    this._title = value;
  }

  _setDescription(String value) {
    this._description = value;
  }

  _setPrice(String value) {
    this._price = double.tryParse(value);
  }

  // textfield
  Widget _buildTextFormField(String title, int numOfLines, TextInputType type,
      Function setter, Function validator) {
    return TextFormField(
        keyboardType: type,
        maxLines: numOfLines,
        decoration: InputDecoration(labelText: title),
        validator: validator,
        // autovalidate: true,
        onSaved: (String value) {
          setState(() {
            setter(value);
          });
        });
  } //end build

  // subtmit map form
  void _submitForm() {
    // when all form is okay
    if (!_formKey.currentState.validate())return;
    _formKey.currentState.save();
    // save to the map
    final Map<String, dynamic> product = {
      "title": this._title,
      "description": this._description,
      "price": this._price,
      "image": 'assets/food.jpg'
    };
    print("---ADDING---");
    print("Title: " + this._title);
    print("Description: "+ this._description);
    print("price: "+ this._price.toString());
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              // title
              _buildTextFormField(
                  "Product Title", 1, TextInputType.text, _setTitle,
                  (String value) {
                if (value.isEmpty) return "Required";
              }),
              // description
              _buildTextFormField(
                  "Product Description", 4, TextInputType.text, _setDescription,
                  (String value) {
                if (value.isEmpty) return "Required";
              }),
              // price
              _buildTextFormField(
                  "Product Price", 1, TextInputType.number, _setPrice,
                  (String value) {
                if (double.tryParse(value) == null) return "Required";
              }),
              // save button
              Container(
                  padding: EdgeInsets.only(top: 15.0),
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).accentColor,
                      child: Text("Save"),
                      onPressed: _submitForm)),
            ])));
  }
}
