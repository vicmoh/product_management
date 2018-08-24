import 'package:flutter/material.dart';
import './pages/product_admin.dart';
import './pages/product.dart';
import './pages/products.dart';
import './pages/auth.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped-models/main.dart';
import './models/product.dart';
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
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
      // list of routes
      routes: {
        '/': (BuildContext context) => AuthPage(), // must comment home:
        '/admin': (BuildContext context) => ProductAdminPage(model),
        '/products': (BuildContext context) => ProductsPage(model),
      },

      // create multiple sub route
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final String productId = pathElements[2];
          final Product product = model.allProducts.firstWhere((Product product){
            return product.id == productId;
          });
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(product),
          );
        }
        return null;
      },

      // when route doesnt exist go to default
      onUnknownRoute: (RouteSettings setting) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(model));
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
    ));
  } //end build
} //end class
