import 'package:flutter/material.dart';

class Products extends StatelessWidget{
  // instances
  final List<String> products;
  // constructor
  Products([this.products = const []]){
    print("[Products Widget] Constructor");
  }//end contructor

  Widget _buildProductItem(BuildContext context, int index){
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/food.jpg'),
          Text(products[index]),
        ],
      ),
    );
  }//end func

  @override
  Widget build(BuildContext context) {
    print("[product widget] build");
    // using map to return the list of product image
    return products.length > 0 ? ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    ) : Center(child: Text("No product found, please add some"));
  }//end build
}//end class