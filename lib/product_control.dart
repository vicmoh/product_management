import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text("Add Product"),
      onPressed: (){
        setState( () {
          _products.add('Advance Food Tester');
        });
      },
    );
  }//end build
}//end class