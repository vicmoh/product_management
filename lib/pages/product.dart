import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  ProductPage(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        print("back button pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Product Detail")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(this.imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(this.title),
            ),
            Container(
                child: RaisedButton(
                  color: Colors.purple,
                  child: Text('DELETE', style: TextStyle(color: Colors.white),),
                  onPressed: () => Navigator.pop(context, true),
                ),
                padding: EdgeInsets.all(10.0)),
          ],
        ),
      ),
    );
  } //end build
} //end class
