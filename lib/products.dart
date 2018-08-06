import 'package:flutter/material.dart';
import './pages/product.dart';

class Products extends StatelessWidget {
  // instances
  final List<Map<String, dynamic>> products;
  // constructor
  Products(this.products) {
    print("[Products Widget] Constructor");
  } //end contructor

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          // image
          Image.asset(products[index]['image']),
          SizedBox(height: 15.0),

          // food type and price
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // title
            Text(
              products[index]['title'],
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oswald'),
            ),
            // spacing
            SizedBox(
              width: 10.0,
            ),
            // price
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
                child: Text(
                  '\$${products[index]['price'].toString()}',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5.0)))
          ]),

          // detail button
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Details"),
                onPressed: () {
                  return Navigator.pushNamed<bool>(
                      context, '/product/' + index.toString());
                },
              ),
            ],
          ),
        ],
      ),
    );
  } //end func

  Widget _buildProductList() {
    Widget productCards =
        Center(child: Text("No product found, please add some"));
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    } //end if
    return productCards;
  } //end func

  @override
  Widget build(BuildContext context) {
    print("[product widget] build");
    return _buildProductList();
  } //end build
} //end class
