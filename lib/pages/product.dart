import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  ProductPage(this.title, this.imageUrl, this.price, this.description);

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
            // image
            Image.asset(this.imageUrl),

            // food label
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(this.title)
            ),

            // price and location
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Union Square, San Francisco",
                  style: TextStyle(fontFamily: "Oswald", color: Colors.grey),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      " | ",
                      style: TextStyle(color: Colors.grey),
                    )),
                Text("\$" + this.price.toString()),
              ],
            ),

            // description
            SizedBox(
              height: 15.0,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  this.description,
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  } //end build
} //end class
