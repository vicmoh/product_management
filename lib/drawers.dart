import 'package:flutter/material.dart';
import './pages/product_admin.dart';
import './pages/products.dart';

class MenuDrawer extends StatelessWidget{

  Route _pageRouteTo(Widget thePage, BuildContext context){
    return MaterialPageRoute(
      builder: (context) =>thePage
    );
  }//end route

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(title: Text("Choose"),
              // remove hamburger icon
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: Text("Manage Product"),
              onTap: () {
                Navigator.pushReplacement(context, 
                  _pageRouteTo(ProductAdminPage(),context)
                );
              }, 
            ),
            ListTile(
              title: Text("Products"),
              onTap: () {
                Navigator.pushReplacement(context, 
                  _pageRouteTo(ProductsPage(), context)
                );
              }, 
            ),
          ],
        )
      );
    }
}