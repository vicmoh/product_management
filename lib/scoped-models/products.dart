import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  List<Product> get products {
    return List.from(_products);
  }//end func

  Product get selectedProduct{
    if(_selectedProductIndex == null) return null;
    return _products[_selectedProductIndex];
  }//end func

  int get selectedProductIndex{
    return _selectedProductIndex;
  }//end func

  void selectProduct(int index){
    this._selectedProductIndex = index;
  }//end func

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  } //end func

  void deleteProduct() {
    _products.removeAt(this._selectedProductIndex);
    _selectedProductIndex = null;
  } //end func

  void updateProduct(Product product) {
    _products[this._selectedProductIndex] = product;
    _selectedProductIndex = null;
  }//end func
}//end class
