import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget{
  //dec instances
  final String startingProduct;
  // constructor
  ProductManager({this.startingProduct}){
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
  // can use final and use method to add
  // if using = const [] on right side
  // when assigning, then list cannot be changed
  final List<String> _products = [];

  //recomend init state like this
  @override
  void initState() {
    print("[productManager State] initState");
    _products.add(widget.startingProduct);
    super.initState();
  }//end init state

  // will execute when you data
  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[productManager state] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }//end func

  void _addProduct(String product){
     setState( () {
      _products.add(product);
    });
  }//end func

  @override
  Widget build(BuildContext context){
    // button to add the product
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: ProductControl(_addProduct),
      ),
      Products(_products),
    ]);
  }//end build
}//end class