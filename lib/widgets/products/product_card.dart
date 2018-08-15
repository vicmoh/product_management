import 'package:flutter/material.dart';
import './price_tags.dart';
import '../ui_elements/title_default.dart';
import './address_tag.dart';
import '../../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info),
      color: Theme.of(context).accentColor,
      onPressed: () => Navigator.pushNamed<bool>(
          context, '/product/' + productIndex.toString()),
    );
  } //end icon button build

  Widget _buildFavIconButton(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {

      // return fav button
      return IconButton(
        icon: Icon(model.products[productIndex].isFavorite
            ? Icons.favorite
            : Icons.favorite_border),
        color: Colors.red,
        onPressed: () {
          model.selectProduct(productIndex);
          model.toggleProductFavoriteStatus();
        },
      );
    });
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
              _buildIconButton(context),
              // fav button
              _buildFavIconButton(context),
            ],
          ),
        ],
      ),
    );
  } //end build
}
