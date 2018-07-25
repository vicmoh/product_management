import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget{
  final Function addProduct;
  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text("Add Product", style: TextStyle(color: Colors.white)),
      onPressed: (){
        // using map
        addProduct({"title": "Chocolate", "image": "assets/food.jpg"});
      },
    );
  }//end build
}//end class