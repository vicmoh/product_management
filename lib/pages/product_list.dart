import 'package:flutter/material.dart';
import './product_edit.dart';
import '../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget{
  final MainModel model;
  ProductListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductListPageState();
  }
}

class _ProductListPageState extends State<ProductListPage> {

  @override
  initState(){
    widget.model.fetchProducts(onlyForUser: true);
    super.initState();
  }//end init

  Widget _buildEditButton(
      BuildContext context, int index, MainModel model) {
    // return icon button
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(model.allProducts[index].id);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return ProductEditPage();
            })
          ).then((_){
            model.selectProduct(null);
          });
        });
  } //end edit build button func

  Widget _content(BuildContext context, int index, MainModel model) {
    print("---PRODUCTS LIST PAGE---");
    print("title: " + model.allProducts[index].title);
    return Container(
        // padding: EdgeInsets.only(bottom: 3.0),
        child: Container(
            // color: Colors.white,
            child: Column(children: <Widget>[
      ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(model.allProducts[index].image),
          ),
          title: Text(model.allProducts[index].title),
          subtitle: Text('\$' + model.allProducts[index].price.toString()),
          trailing: _buildEditButton(context, index, model)),
      Divider(),
    ])));
  } //end content func

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
    
      // show empty list
      var emptyListText = Container(
        child: Center(child: Text("List empty", textScaleFactor: 1.3))
      );
      if(model.allProducts == null) return emptyListText;
      if(model.allProducts.length == 0) return emptyListText;
      
      // return the list view
      return ListView.builder(
          itemCount: model.allProducts.length,
          itemBuilder: (BuildContext context, int index) {
            // dismissible to remove the item to swipe
            return Dismissible(
              background: Container(color: Colors.red),
        
              // condition when swipe
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  print('swiped end to start');
                  model.selectProduct(model.allProducts[index].id);
                  model.deleteProduct();
                } else if (direction == DismissDirection.startToEnd) {
                  print('swipe start to end');
                } else {
                  print('other swipe');
                }
              },

              // key data and its content
              key: Key(model.allProducts[index].title),
              child: _content(context, index, model),
            );
          });
    }));
  }
}
