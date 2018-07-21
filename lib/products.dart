import 'package:flutter/material.dart';

class Products extends StatelessWidget{
  // instances
  final List<String> products;
  // constructor
  Products(this.products);

  @override
  Widget build(BuildContext context) {
    // using map to return the list of product image
    return Column(
      children: this.products.map( 
        (element) => Card(
          child: Column(
            children: <Widget>[
              Image.asset('assets/food.jpg'),
              Text(element),
            ],
          ),
        )
      ).toList(),
    );
  }//end build
}//end class