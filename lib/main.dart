import 'package:flutter/material.dart';
import './pages/product_admin.dart';
import './pages/product.dart';
import './pages/products.dart';
import './pages/auth.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';

/// main to run the app
void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(new MyApp());
} //end main

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  } //end func

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  } //end func

  void _updateProduct(int index, Map<String, dynamic> product) {
    setState(() {
      _products[index] = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // list of routes
      routes: {
        '/': (BuildContext context) => AuthPage(), // must comment home:
        '/admin': (BuildContext context) => ProductAdminPage(
            _addProduct, _updateProduct, _deleteProduct, _products),
        '/products': (BuildContext context) => ProductsPage(_products),
      },

      // create multiple sub route
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'],
                _products[index]['image'],
                _products[index]['price'],
                _products[index]['description']),
          );
        }
        return null;
      },

      // when route doesnt exist go to default
      onUnknownRoute: (RouteSettings setting) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(_products));
      },

      // theme and setting
      // debugShowMaterialGrid: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      // home: AuthPage(),
    );
  } //end build
} //end class
