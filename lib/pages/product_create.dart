import 'package:flutter/material.dart';

class ProductCreatePage extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Center(
        child: RaisedButton(
          child: Text("save"),

          // sliding modal from bottom
          onPressed: () {
            showModalBottomSheet(context: context,
              builder: (BuildContext context){
                return Center(child: Text("This is Modal!"));
              }
            );
          }

        ),
      );
    }
}