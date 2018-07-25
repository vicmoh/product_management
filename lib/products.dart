import 'package:flutter/material.dart';
import './pages/products.dart';

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
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Details"),
                onPressed: () {
                  return Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProductPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }//end func

  Widget _buildProductList(){
    Widget productCards = Center(child: Text("No product found, please add some"));
    if(products.length > 0){
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    }//end if
    return productCards;
  }//end func

  @override
  Widget build(BuildContext context) {
    print("[product widget] build");
    return _buildProductList(); 
  }//end build
}//end class