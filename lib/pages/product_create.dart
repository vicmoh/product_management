import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget{
  @override 
  State <StatefulWidget> createState(){
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage>{

  String titleValue = '';
  String descriptionValue = '';
  double priceValue = 0.0;

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

      // title
      TextField(
        onChanged: (String value){
          setState(() {
            this.titleValue = value;
          });
        }
      ),
      
      // description
      TextField(
        maxLines: 4,
        onChanged: (String value){
          setState(() {
            this.descriptionValue = value;
          });
        }
      ),

      // price
      TextField(
        keyboardType: TextInputType.number,
        onChanged: (String value){
          setState(() {
            this.priceValue = double.parse(value);
          });
        }
      ),

    ],);
  }
}