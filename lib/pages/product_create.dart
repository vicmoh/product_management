import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget{
  @override 
  State <StatefulWidget> createState(){
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage>{

  String titleValue = '';

  _modalShowCase(BuildContext context){
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

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Column(children: <Widget>[
        TextField(onChanged: (String value){
          setState(() {
            titleValue = value;
          });
        },),
        Text(titleValue),
      ],);
    }
}