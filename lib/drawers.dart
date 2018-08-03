import 'package:flutter/material.dart';
// import './pages/product_admin.dart';
// import './pages/products.dart';

class MenuDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    // menu button
    _menuButton(String label, String page){
      return ListTile(
        title: Text(label),
        onTap: () {
          Navigator.pushReplacementNamed(context, page);
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
          _menuButton("Manage Product", '/admin'),
          _menuButton("Products", "/"),
        ],
      )
    );
  }//end build
}//end classs