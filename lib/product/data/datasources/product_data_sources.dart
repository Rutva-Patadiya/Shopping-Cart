import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

// This class fetches data from Firebase Fire store, which contains the product details.
class ProductDataSources {
  static const productCollection = "products";
  static const categoriesCollection = "categories";

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection(productCollection).get();

      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      handleException(e);
      return [];
    }
  }

  //This Method fetches the categories from the firebase

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection(categoriesCollection)
              .get();

      if (snapshot.docs.isEmpty) {
        if (kDebugMode) {
          print(
            "Warning: No documents found in the '$categoriesCollection' collection. "
            "It may be empty or the collection name might be incorrect.",
          );
        }
        return [];
      }

      return snapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      handleException(e);
      return [];
    }
  }

  //It will be called when there is an exception
  void handleException(e) {
    if (e is FirebaseException) {
      if (e.code == 'permission-denied') {
        if (kDebugMode) print('Permission denied: ${e.message}');
      } else if (e.code == 'unavailable') {
        if (kDebugMode) print('Unavailable: ${e.message}');
      } else {
        if (kDebugMode) print('FirebaseException: ${e.message}');
      }
    } else {
      if (kDebugMode) print('Unknown exception: $e');
    }
  }
}
