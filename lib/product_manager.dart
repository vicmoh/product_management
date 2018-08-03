import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget{
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);
  
  @override
  Widget build(BuildContext context){
    // button to add the product
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: ProductControl(this.addProduct),
      ),
      Expanded(
        child: Products(this.products, deleteProduct: this.deleteProduct),
      ),
    ]);
  }//end build
}//end class