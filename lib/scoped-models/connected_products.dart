import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/user.dart';
import 'dart:convert';
import 'dart:async';
import '../scoped-models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

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
          'https://flutter-products-20260.firebaseio.com/products.json?auth=${_authenticatedUser.token}',
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
            'https://flutter-products-20260.firebaseio.com/products/${deletedProductId}.json?auth=${_authenticatedUser.token}')
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

  Future<Null> fetchProducts({onlyForUser = false}) {
    _isLoading = true;
    return http
        .get(
            'https://flutter-products-20260.firebaseio.com/products.json?auth=${_authenticatedUser.token}')
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
      } //end if

      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          userEmail: productData['userEmail'],
          userId: productData['userId'],
          isFavorite: productData['wishlistUsers'] == null
              ? false
              : (productData['wishlistUsers'] as Map<String, dynamic>)
                  .containsKey(_authenticatedUser.id),
        );
        fetchedProductList.add(product);
        print('wishlistUsers containskey = ' + _authenticatedUser.id);
      });
      _products = onlyForUser ? fetchedProductList.where((Product product){
        return product.userId == _authenticatedUser.id;
      }).toList() : fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  } //end func

  void toggleProductFavoriteStatus() async {
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
    http.Response response;

    // add wishlist to database
    if (newFavoriteStatus) {
      response = await http.put(
          'https://flutter-products-20260.firebaseio.com/products/' +
              '${selectedProduct.id}/wishlistUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}',
          body: json.encode(true));
    } else {
      await http.delete('https://flutter-products-20260.firebaseio.com/products/' +
          '${selectedProduct.id}/wishlistUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
    } //end if
    if (response.statusCode != 200 && response.statusCode != 201) {
      // error handling ...
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
    } //end if
  } //end func

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    // update and refresh: it re-render the page
    this.selectProduct(null);
    notifyListeners();
  } //end func

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
            'https://flutter-products-20260.firebaseio.com/products/${selectedProduct.id}.json?auth=${_authenticatedUser.token}',
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
  //dec instance
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  // getters
  User get user => _authenticatedUser;
  PublishSubject<bool> get userSubject => _userSubject;

  /// the email and password
  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCaNnWM1rcSulA1ZvlIXxsQsW5D1nQJRKQ',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
    } else {
      response = await http.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyCaNnWM1rcSulA1ZvlIXxsQsW5D1nQJRKQ',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
    } //end if

    // error check
    bool hasError = true;
    final Map<String, dynamic> responseData = json.decode(response.body);
    var message = '';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded';
      // new user if successful
      _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);
      setAuthTimeout(int.parse(responseData['expiresIn']));
      final now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userSubject.add(true);
      // shared prefs for storing local
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_NOT_EXISTS') {
      message = 'This email was not found.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The password is invalid.';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists.';
    } else {
      message = 'Something went wrong.';
    } //end if
    print(responseData);
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  } //end func

  /// auto authenticate when open is open
  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final expiryTimeString = prefs.getString('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        return;
      } //end if
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final int tokenLifespan = parsedExpiryTime.difference(now).inMilliseconds;
      _authenticatedUser = User(id: userId, email: userEmail, token: token);
      _userSubject.add(true);
      setAuthTimeout(tokenLifespan);
      notifyListeners();
    } //end if
  } //end func

  /// logout the user
  void logout() async {
    print('Logout');
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    // or do it individually
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    _userSubject.add(false);
  } //end func

  /// set auth timeout which will logout
  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), () {
      logout();
      // _userSubject.add(false);
    });
  } //end func
} //end class

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading => _isLoading;
}
