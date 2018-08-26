import 'package:flutter/material.dart';
import './logout_list_tile.dart';
// import './pages/product_admin.dart';
// import './pages/products.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // menu button
    _menuButton(IconData icon, String label, String page) {
      return ListTile(
        leading: Icon(icon),
        title: Text(label),
        onTap: () {
          Navigator.pushReplacementNamed(context, page);
        },
      );
    } //end func

    // drawer
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Choose"),
            // remove hamburger icon
            automaticallyImplyLeading: false,
          ),
          _menuButton(Icons.edit, "Manage Product", '/admin'),
          _menuButton(Icons.shop, "Products", '/products'),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  } //end build
} //end classs
