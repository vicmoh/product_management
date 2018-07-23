import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text("Add Product"),
      onPressed: (){
        
      },
    );
  }//end build
}//end class