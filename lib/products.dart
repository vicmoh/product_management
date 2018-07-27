import 'package:flutter/material.dart';
import './pages/product_page.dart';

class Products extends StatelessWidget {
  // instances
  final List<Map> products;
  final Function deleteProduct;
  // constructor
  Products(this.products, {this.deleteProduct}) {
    print("[Products Widget] Constructor");
  } //end contructor

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Details"),
                onPressed: () {
                  return Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProductPage(
                          products[index]['title'], products[index]['image']),
                    ),
                  ).then((bool value){
                    if(value = true){
                      deleteProduct(index);
                    }//end if
                    print("push them:"+value.toString()); 
                  });
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
