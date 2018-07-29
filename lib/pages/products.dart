import 'package:flutter/material.dart';
import '.././product_manager.dart';
import './product_admin.dart';

class ProductsPage extends StatelessWidget {

  Route _adminPageRoute(BuildContext context){
    return MaterialPageRoute(
      builder: (context) =>
      ProductAdminPage()
    );
  }//end route
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(title: Text("Choose"),
              // remove hamburger icon
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: Text("Manage Product"),
              onTap: () {
                Navigator.push(context, 
                  _adminPageRoute(context)
                );
              }, 
            ),
          ],
        )
      ),

      // app bar
      appBar: AppBar(
        title: Text("Title"),
        centerTitle: true,
      ),

      // body
      body: ProductManager(),
    );
  }
}
