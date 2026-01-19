import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_cart/Constants.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';
import 'package:shopping_cart/utils/firebase_utils.dart';

import '../models/category_model.dart'; // import '../models/product_color_model.dart';
import '../models/product_color_model.dart';
import '../models/product_model.dart';

// This class fetches data from Firebase Fire store, which contains the product details.
class ProductDataSources {
  static final ProductDataSources _instance = ProductDataSources._internal();

  factory ProductDataSources() => _instance;

  ProductDataSources._internal();
  late Product product;
  late CategoryModel categoryModel;

  //Fetches the products from the firebase
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final productSnapshot = await FirebaseFirestore.instance
          .collection(Constants.productCollection)
          .get()
          .handleFirebase(logName: "fetchProducts");

      if (productSnapshot == null || productSnapshot.docs.isEmpty) {
        return [];
      }
      return productSnapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  //Fetches the categories from the firebase
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final categorySnapshot = await FirebaseFirestore.instance
          .collection(Constants.categoriesCollection)
          .get()
          .handleFirebase(logName: "fetchCategories");

      if (categorySnapshot == null || categorySnapshot.docs.isEmpty) {
        if (kDebugMode) {
          print(
            "Warning: No documents found in the '$Constants.categoriesCollection' collection. "
                "It may be empty or the collection name might be incorrect.",
          );
        }
        return [];
      }

      return categorySnapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();
    }
    catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchAllVariants(String productId) async {
    final Map<String, dynamic> result = {};

    try {
      final productRef = FirebaseFirestore.instance
          .collection(Constants.productCollection)
          .doc(productId);

      final querySnapshot =
          await FirebaseFirestore.instance
              .collection(Constants.variantsCollection)
              .where('product_id', isEqualTo: productRef)
              .get();

      if (querySnapshot.docs.isEmpty) {
        return result; // Return empty map if no variants found
      }

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final name = data['name'];

        switch (name) {
          case Constants.size:
            result['sizes'] = List<String>.from(
              (data['sizes'] ?? []).map((e) => e.toString()),
            );
            break;
          case Constants.color:
            result['color'] = List<ColorItem>.from(
              (data['color'] ?? []).map((e) => ColorItem.fromMap(e)),
            );
            break;
          case Constants.weight:
            result['weight'] = List<String>.from(
              (data['weight'] ?? []).map((e) => e.toString()),
            );
            break;
          case Constants.litre:
            result['litre'] = List<String>.from(
              (data['litre'] ?? []).map((e) => e.toString()),
            );
            break;
          case Constants.quantity:
            result['set_size'] = List<String>.from(
              (data['set_size'] ?? []).map((e) => e.toString()),
            );
            break;
          default:
            // Handle unexpected variant types
            print('Unknown variant type: $name');
        }
      }
    } catch (e, stackTrace) {
      // Log the error for debugging
      print('Error fetching variants for product $productId: $e');
      print(stackTrace);
    }

    return result;
  }

  //It will be called when there is an exception
  // void handleException(e) {
  //   if (e is FirebaseException) {
  //     if (e.code == 'permission-denied') {
  //       if (kDebugMode) print('Permission denied: ${e.message}');
  //     } else if (e.code == 'unavailable') {
  //       if (kDebugMode) print('Unavailable: ${e.message}');
  //     } else {
  //       if (kDebugMode) print('FirebaseException: ${e.message}');
  //     }
  //   } else {
  //     if (kDebugMode) print('Unknown exception: $e');
  //   }
  // }
}
