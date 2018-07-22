import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatefulWidget{
  //dec instances
  final String stratingProduct;
  // constructor
  ProductManager(this.stratingProduct){
    print("[productManager widget] createState()");
  }//end consrtuctor

  @override
  State<StatefulWidget> createState(){
    print("[productManager widget] createState");
    return _ProductManagerState();
  }//end build
}//end class

class _ProductManagerState extends State<ProductManager>{
  // dec instances
  List<String> _products = ["Food Tester"];

  //recomend init state like this
  @override
  void initState() {
    print("[productManager State] initState");
    _products.add(widget.stratingProduct);
    super.initState();
  }//end init state

  // will execute when you data
  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[productManager state] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }//end func

  @override
  Widget build(BuildContext context){
    // button to add the product
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text("Add Product"),
          onPressed: (){
            setState( () {
              _products.add('Advance Food Tester');
            });
          },
        ),
      ),
      Products(_products),
    ]);
  }//end build
}//end class