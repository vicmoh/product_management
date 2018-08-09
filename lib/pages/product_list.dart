import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  ProductListPage(this.products);

  _content(BuildContext context, int index) {
    print("---PRODUCTS LIST PAGE---");
    print("title: " + products[index]['title']);
    return Container(

        padding: EdgeInsets.only(bottom: 3.0),
        child: Container(
            color: Colors.white,
            child: ListTile(
              leading: Image.asset(products[index]['image'], height: 25.0),
              title: Text(products[index]['title']),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return _content(context, index);
      },
    ));
  }
}
