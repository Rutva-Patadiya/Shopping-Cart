import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

// This class fetches data from Firebase Fire store, which contains the product details.
class ProductDataSources {
  static const productCollection = "products";
  static const usersCollection = "users";
  static const categoriesCollection = "categories";

  //
  // Future<UserModel> setUserDetails() async {
  //   final snapshot =
  //       await FirebaseFirestore.instance
  //           .collection(usersCollection)
  //           .doc("users")
  //           .set();
  // }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      // it fetches documents from Firebase
      final snapshot =
          await FirebaseFirestore.instance.collection(productCollection).get();
      // loops over each document & docs:property of snapshot & give list of all the product documents Each doc contains fields like Name..

      //when you call this constructor, it will return a list of product model (doc.data() returns map)
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      handleException(e);
      // rethrow;
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
