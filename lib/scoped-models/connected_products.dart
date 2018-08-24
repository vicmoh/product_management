import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/user.dart';
import 'dart:convert';
import 'dart:async';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _selProductId;
  bool _isLoading = false;
} //end class

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  } //end func

  List<Product> get displayProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  } //end func

  Product get selectedProduct {
    if (selectedProductId == null) return null;
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  } //end func

  bool get displayFavoriteOnly {
    return _showFavorites;
  }

  String get selectedProductId {
    return _selProductId;
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    // update and refresh: it re-render the page
    if (_selProductId != null) notifyListeners();
  } //end funcs

  Future<bool> addProduct(
      String title, String description, String image, double price) async {
    _isLoading = true;
    notifyListeners();
    // post to firebase
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://www.iexpats.com/wp-content/uploads/2016/11/chocolate.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };

    try {
      final http.Response response = await http.post(
          'https://flutter-products-20260.firebaseio.com/products.json',
          body: json.encode(productData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Product newProduct = Product(
        id: responseData['name'],
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id,
      );
      _products.add(newProduct);
      // update and refresh: it re-render the page
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return true;
    }
  } //end func

  Future<bool> deleteProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    return http
        .delete(
            'https://flutter-products-20260.firebaseio.com/products/${deletedProductId}.json')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  } //end func

  Future<Null> fetchProducts() {
    _isLoading = true;
    return http
        .get('https://flutter-products-20260.firebaseio.com/products.json')
        .then<Null>((http.Response response) {
      _isLoading = false;
      print(json.decode(response.body));
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);

      print("--------------json---------------");
      print(json.decode(response.body));

      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId']);
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = _products[selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProdcut = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavoriteStatus);
    _products[selectedProductIndex] = updateProdcut;
    // update and refresh: it re-render the page
    notifyListeners();
  } //end func

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    // update and refresh: it re-render the page
    this.selectProduct(null);
    notifyListeners();
  }

  Future<bool> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;

    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'https://www.iexpats.com/wp-content/uploads/2016/11/chocolate.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    return http
        .put(
            'https://flutter-products-20260.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      _products[selectedProductIndex] = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
    ;
  } //end func
} //end class

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(
      id: "TestID",
      email: email,
      password: password,
    );
  }

  Future<Map<String, dynamic>> signup(String email, password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final http.Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyCaNnWM1rcSulA1ZvlIXxsQsW5D1nQJRKQ',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});
    print(json.decode(response.body));
    return {'success': true, 'message': 'Authentication succeeded!'};
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading => _isLoading;
}
