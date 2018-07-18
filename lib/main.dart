import 'package:flutter/material.dart';

/// main to run the app
void main(){
  runApp(new MyApp());
}//end main

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Title"),
          centerTitle: true,
        ),
      ),
    );
  }//end build
}//end class