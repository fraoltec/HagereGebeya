import 'package:HagereGebeya/Locator.dart';
import 'package:HagereGebeya/model/productModel.dart';
import 'package:HagereGebeya/pages/ProductCard.dart';
import 'package:HagereGebeya/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:HagereGebeya/provider/CRUDModel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> products;

  @override
  Widget build(BuildContext context) {
    
    final productProvider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider<UserProvider>(
      builder: (context) => locator<UserProvider>(),
      child: Consumer<UserProvider>(
        builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('Home')),
      ),
      body: Container(
        child: StreamBuilder(
            stream: productProvider.fetchProductsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                products = snapshot.data.documents
                    .map((doc) => Product.fromMap(doc.data, doc.documentID))
                    .toList();
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (buildContext, index) =>
                      ProductCard(productDetails: products[index]),
                );
              } else {
                return Text('fetching');
              }
            }),
      ),
        ),
      ));  
  }
}