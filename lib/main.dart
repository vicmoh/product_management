import 'package:flutter/material.dart';
import 'package:flutter_course/products.dart';

/// main to run the app
void main(){
  runApp(new MyApp());
}//end main

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }//end build
}//end class

class _MyAppState extends State<MyApp>{
  List<String> _products = ["Food Tester"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        // app bar
        appBar: AppBar(
          title: Text("Title"),
          centerTitle: true,
        ),

        // body
        body: Column(
          children: [

            // button to add the product
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



          ],
        ), 

      ),
    );
  }//end build
}//end class