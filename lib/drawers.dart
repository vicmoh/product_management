import 'package:flutter/material.dart';
import './pages/product_admin.dart';

class MenuDrawer extends StatelessWidget{

  Route _adminPageRoute(BuildContext context){
    return MaterialPageRoute(
      builder: (context) =>
      ProductAdminPage()
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
                  _adminPageRoute(context)
                );
              }, 
            ),
          ],
        )
      );
    }
}