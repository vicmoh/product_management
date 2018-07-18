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

        // app bar
        appBar: AppBar(
          title: Text("Title"),
          centerTitle: true,
        ),

        // body
        body: Card(
          child: Column(
            children: <Widget>[
              Image.asset('assets/food.jpg'),
              Text("Food Paradise")
            ],
          ),
        ),

      ),
    );
  }//end build
}//end class