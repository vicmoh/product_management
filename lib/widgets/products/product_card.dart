import 'package:flutter/material.dart';
import './price_tags.dart';
import '../ui_elements/title_default.dart';
import './address_tag.dart';

class ProductCard extends StatelessWidget{

  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Card(
      child: Column(
        children: <Widget>[
          // image
          Image.asset(product['image']),
          SizedBox(height: 15.0),

          // food type and price
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // title
            TitleDefault(product['title']),
            // spacing
            SizedBox(
              width: 10.0,
            ),
            // price
            PriceTag(product['price']),
          ]),

          // address
          AddressTag("Union Square, San Fransisco"),

          // detail button
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              // info button
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              ),
              // fav button
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              )
            ],
          ),
        ],
      ),
    );
  }//end build
}