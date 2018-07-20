import 'package:flutter/material.dart';

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
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text("Add Product"),
                onPressed: (){
                  
                },
              ),
            ),
            Column(
              children: this._products.map( 
                (element) => Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/food.jpg'),
                      Text(element),
                    ],
                  ),
                )
              ).toList(),
            ),
          ],
        ), 


      ),
    );
  }//end build
}//end class