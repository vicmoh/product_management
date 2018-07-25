import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text("Product Detail")
        ),
        body: Center(
          child: Column(children: <Widget>[
            Text("Details"),
            RaisedButton(child: Text('BACK'), 
              onPressed: () => Navigator.pop(context),
            )
          ],)
        ),
      );
    }//end build
}//end class