import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HagereGebeya/Locator.dart';
import 'package:HagereGebeya/model/productModel.dart';
import 'package:HagereGebeya/service/Api.dart';


class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Product> products;

  Future<List<Product>> fetchProducts() async {
    var result = await _api.getDataCollection();
    products = result.documents
        .map((doc) => Product.fromMap(doc.data, doc.documentID))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Product> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Product.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
     await _api.removeDocument(id) ;
     return ;
  }
  Future updateProduct(Product data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Product data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }


}