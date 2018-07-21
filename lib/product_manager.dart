import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _ProductManagerState();
  }//end build
}//end class

class _ProductManagerState extends State<ProductManager>{
  // dec instances
  List<String> _products = ["Food Tester"];

  @override
  Widget build(BuildContext context){
    // button to add the product
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
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