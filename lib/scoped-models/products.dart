import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';
import './connected_products.dart';

class ProductsModel extends ConnectedProducts {

  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(products);
  }//end func

  List<Product> get displayProducts {
    if(_showFavorites){  
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }//end func

  Product get selectedProduct{
    if(selectedProductIndex == null) return null;
    return products[selectedProductIndex];
  }//end func

  bool get displayFavoriteOnly => _showFavorites;

  int get selectedProductIndex => selProductIndex;

  void selectProduct(int index){
    selProductIndex = index;
    // update and refresh: it re-render the page 
    notifyListeners();
  }//end func

  void deleteProduct() {
    products.removeAt(this.selectedProductIndex);
    selProductIndex = null;
    // update and refresh: it re-render the page 
    notifyListeners();
  } //end func

  void toggleProductFavoriteStatus(){
    final bool isCurrentlyFavorite = products[selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProdcut = Product(
      title: selectedProduct.title,
      description: selectedProduct.description,
      price: selectedProduct.price,
      image: selectedProduct.image,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
      isFavorite: newFavoriteStatus 
    );
    products[selectedProductIndex] = updateProdcut;
    // update and refresh: it re-render the page 
    notifyListeners();
    // section 11, lect 157
    selProductIndex = null;
  }//end func

  void toggleDisplayMode(){
    _showFavorites = !_showFavorites;
    // update and refresh: it re-render the page 
    notifyListeners();
  }

  void updateProduct(String title, String description, String image, double price) {
    products[selectedProductIndex] = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    selProductIndex = null;
    // update and refresh: it re-render the page 
    notifyListeners();
  }//end func
}//end class
