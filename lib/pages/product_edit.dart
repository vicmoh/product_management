import 'package:flutter/material.dart';
import '../widgets/helpers/ensure-visible.dart';
import '../models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;
  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final _titleFocusNode = FocusNode();

  //------------------------------------------
  // setter functions
  //------------------------------------------

  _setTitle(String value) {
    this._formData['title'] = value;
  }

  _setDescription(String value) {
    this._formData['description'] = value;
  }

  _setPrice(String value) {
    this._formData['price'] = double.tryParse(value);
  }

  //------------------------------------------
  // validator functions
  //------------------------------------------

  String _validateString(String value) {
    if (value.isEmpty) {
      return "Required";
    } else {
      return null;
    }
  }

  String _validateNumber(String value) {
    if (double.tryParse(value) == null) {
      return "Required and must be a number";
    } else {
      return null;
    }
  }

  //------------------------------------------
  // widget functions
  //------------------------------------------

  // popup modal from bottom
  Widget _modalShowCase(BuildContext context) {
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

  // textfield
  Widget _buildTextFormField(
      {@required String title,
      @required String data,
      int numOfLines = 1,
      TextInputType inputType = TextInputType.text,
      @required Function setter,
      @required Function validator}) {
    return EnsureVisibleWhenFocused(
        focusNode: this._titleFocusNode,
        child: TextFormField(
            focusNode: this._titleFocusNode,
            initialValue: data,
            keyboardType: inputType,
            maxLines: numOfLines,
            decoration: InputDecoration(labelText: title),
            validator: validator,
            // autovalidate: true,
            onSaved: (String value) {
              // setState(() {
              setter(value);
              // });
            }));
  } //end build

  // submit map form
  void _submitForm() {
    // when all form is okay
    if (!_formKey.currentState.validate()) return;
    // save the current data on field
    _formKey.currentState.save();
    // save it in temp to reduce redundancy
      Product toBeAdded = new Product(
      title: this._formData['title'],
      description: this._formData['description'],
      price: this._formData['price'],
      image: this._formData['image']);

    if (widget.product == null) {
      // save to the map
      print("---ADDING---");
      print("Title: " + toBeAdded.title);
      print("Description: " + toBeAdded.description);
      print("price: " + toBeAdded.price.toString());
      widget.addProduct(toBeAdded);
    } else {
      print("---UPDATING PRODUCT---");
      widget.updateProduct(widget.productIndex, toBeAdded);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    // error check
    Product tempProduct =
        Product(title: "", description: "", price: 0.0, image: "");
    var tempPrice = '';
    if (widget.product != null) {
      tempProduct = widget.product;
      tempPrice = widget.product.price.toString();
    } //end if

    // TODO: implement build
    final Widget pageContent = GestureDetector(
        onTap: () {
          // IMPORTANT: gesture to put keyboard down when clicked
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.all(15.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  // title
                  _buildTextFormField(
                      title: "Product Title",
                      data: tempProduct.title,
                      setter: _setTitle,
                      validator: _validateString),
                  // description
                  _buildTextFormField(
                      title: "Product Description",
                      data: tempProduct.description,
                      numOfLines: 4,
                      setter: _setDescription,
                      validator: _validateString),
                  // price
                  _buildTextFormField(
                      title: "Product Price",
                      data: tempPrice,
                      inputType: TextInputType.number,
                      setter: _setPrice,
                      validator: _validateNumber),
                  // save button
                  Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Theme.of(context).accentColor,
                          child: Text("Save"),
                          onPressed: _submitForm)),
                ]))));
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
