import 'package:flutter/material.dart';
import './pages/auth_page.dart';
// import 'package:flutter/rendering.dart';

/// main to run the app
void main(){
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(new MyApp());
}//end main

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      home: AuthPage(),

    );
  }//end build
}//end class