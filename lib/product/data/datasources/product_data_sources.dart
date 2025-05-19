import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

// This class fetches data from Firebase Fire store, which contains the product details.
class ProductDataSources {
  //need to define collection name as const because when we change the name of collection it should be changed everywhere
  static const productCollection = "products";
  static const categoriesCollection = "categories";

  Future<List<ProductModel>> fetchProducts() async {
    try {
      // it fetches documents from Firebase
      final snapshot =
          await FirebaseFirestore.instance.collection(productCollection).get();
      // loops over each document & docs:property of snapshot & give list of all the product documents Each doc contains fields like Name..
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  //this is for fetching the category name
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection(categoriesCollection)
              .get();

      return snapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
