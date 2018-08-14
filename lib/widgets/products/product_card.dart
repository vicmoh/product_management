import 'package:flutter/material.dart';
import './price_tags.dart';
import '../ui_elements/title_default.dart';
import './address_tag.dart';
import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildIconButton(BuildContext context, IconData icon, Color color) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: () => Navigator.pushNamed<bool>(
          context, '/product/' + productIndex.toString()),
    );
  } //end icon button build

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          // image
          Image.asset(product.image),
          SizedBox(height: 15.0),

          // food type and price
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // title
            TitleDefault(product.title),
            // spacing
            SizedBox(width: 10.0),
            // price
            PriceTag(product.price),
          ]),

          // address
          AddressTag("Union Square, San Fransisco"),

          // detail button
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              // info button
              _buildIconButton(
                  context, Icons.info, Theme.of(context).accentColor),
              // fav button
              _buildIconButton(context, Icons.favorite_border, Colors.red),
            ],
          ),
        ],
      ),
    );
  } //end build
}
