import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool _showFavorites = false;

  List<Product> get products {
    return List.from(_products);
  }//end func

  List<Product> get displayProducts {
    if(_showFavorites){  
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }//end func

  Product get selectedProduct{
    if(_selectedProductIndex == null) return null;
    return _products[_selectedProductIndex];
  }//end func

  bool get displayFavoriteOnly => _showFavorites;

  int get selectedProductIndex => _selectedProductIndex;

  void selectProduct(int index){
    this._selectedProductIndex = index;
    // update and refresh: it re-render the page 
    notifyListeners();
  }//end func

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    // update and refresh: it re-render the page 
    notifyListeners();
  } //end func

  void deleteProduct() {
    _products.removeAt(this._selectedProductIndex);
    _selectedProductIndex = null;
    // update and refresh: it re-render the page 
    notifyListeners();
  } //end func

  void toggleProductfavoriteStatus(){
    final bool isCurrentlyFavorite = _products[_selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProdcut = Product(
      title: selectedProduct.title,
      description: selectedProduct.description,
      price: selectedProduct.price,
      image: selectedProduct.image,
      isFavorite: newFavoriteStatus 
    );
    _products[_selectedProductIndex] = updateProdcut;
    _selectedProductIndex = null;
    // update and refresh: it re-render the page 
    notifyListeners();
  }//end func

  void toggleDisplayMode(){
    _showFavorites = !_showFavorites;
    // update and refresh: it re-render the page 
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[this._selectedProductIndex] = product;
    _selectedProductIndex = null;
    // update and refresh: it re-render the page 
    notifyListeners();
  }//end func
}//end class
