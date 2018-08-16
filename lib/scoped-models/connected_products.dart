import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: _authenticatedUser.email,
      userId: _authenticatedUser.id,
    );
    _products.add(newProduct);
    // update and refresh: it re-render the page
    notifyListeners();
  } //end func
}

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
    if (selectedProductIndex == null) return null;
    return _products[selectedProductIndex];
  } //end func

  bool get displayFavoriteOnly {
    return _showFavorites;
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    // update and refresh: it re-render the page
     if(_selProductIndex != null) notifyListeners();
  } //end funcs

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    // update and refresh: it re-render the page
    _selProductIndex = null;
    notifyListeners();
  } //end func

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = _products[selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProdcut = Product(
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

  void updateProduct(
      String title, String description, String image, double price) {
    _products[selectedProductIndex] = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    // update and refresh: it re-render the page
    notifyListeners();
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
}
