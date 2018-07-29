import 'package:flutter/material.dart';
import './pages/product_admin.dart';
import './pages/products.dart';

class MenuDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    // page routing
    Route _pageRouteTo(Widget thePage){
      return MaterialPageRoute(
        builder: (context) =>thePage
      );
    }//end route

    // menu button
    _menuButton(String label, Widget page){
      return ListTile(
        title: Text(label),
        onTap: () {
          Navigator.pushReplacement(context, 
            _pageRouteTo(page)
          );
        }, 
      );
    }//end func

    // drawer
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(title: Text("Choose"),
            // remove hamburger icon
            automaticallyImplyLeading: false,
          ),
          _menuButton("Manage Product", ProductAdminPage()),
          _menuButton("Products", ProductsPage())
        ],
      )
    );
  }//end build
}//end classs