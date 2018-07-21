import 'package:flutter/material.dart';
import './product_manager.dart';

/// main to run the app
void main(){
  runApp(new MyApp());
}//end main

class MyApp extends StatelessWidget{
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
        body: ProductManager("Food Tester"),

      ),
    );
  }//end build
}//end class