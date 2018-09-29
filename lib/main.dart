import 'package:flutter/material.dart';
import './pages/product_admin.dart';
import './pages/product.dart';
import './pages/products.dart';
import './pages/auth.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped-models/main.dart';
import './models/product.dart';
import 'package:flutter/rendering.dart';

/// main to run the app
void main() {
  debugPaintSizeEnabled = false;
  debugPaintBaselinesEnabled = false;
  debugPaintPointersEnabled = false;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(new MyApp());
} //end main

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  } //end state
} //end class

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    // TODO: implement initState
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      _isAuthenticated = isAuthenticated;
    });
    super.initState();
  } //end func

  @override
  Widget build(BuildContext context) {
    print("building main page");
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        // list of routes
        routes: {
          '/': (BuildContext context) => !_isAuthenticated
              ? AuthPage()
              : ProductsPage(_model), // must comment home:
          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductAdminPage(_model),
          '/products': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsPage(_model),
        },

        // create multiple sub route
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          } //end if

          // path for the products
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId = pathElements[2];
            final Product product =
                _model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => !_isAuthenticated ? AuthPage() :  ProductPage(product),
            );
          }
          return null;
        },

        // when route doesnt exist go to default
        onUnknownRoute: (RouteSettings setting) {
          return MaterialPageRoute(
              builder: (BuildContext context) => !_isAuthenticated ? AuthPage() : ProductsPage(_model));
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
      ),
    );
  } //end build
} //end class
