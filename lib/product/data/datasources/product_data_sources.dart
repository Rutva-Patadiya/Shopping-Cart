import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';

import '../models/category_model.dart';
import '../models/product_color_model.dart';
import '../models/product_model.dart';
import '../models/product_size_model.dart';

// This class fetches data from Firebase Fire store, which contains the product details.
class ProductDataSources {
  static const productCollection = "products";
  static const categoriesCollection = "categories";
  late Product product;
  late CategoryModel categoryModel;
  late ProductSizeModel productSizeModel;

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final productSnapshot =
          await FirebaseFirestore.instance.collection(productCollection).get();

      return productSnapshot.docs
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
      final categorySnapshot =
          await FirebaseFirestore.instance
              .collection(categoriesCollection)
              .get();

      if (categorySnapshot.docs.isEmpty) {
        if (kDebugMode) {
          print(
            "Warning: No documents found in the '$categoriesCollection' collection. "
            "It may be empty or the collection name might be incorrect.",
          );
        }
        return [];
      }

      return categorySnapshot.docs
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

  Future<List<ProductColorModel>> fetchColors(Product product) async {
    try {
      final colorSnapshot =
          await FirebaseFirestore.instance
              .collection(categoriesCollection)
              .where('name', isEqualTo: product.categoryName)
              .limit(1)
              .get();

      if (colorSnapshot.docs.isNotEmpty) {
        final colorDoc = colorSnapshot.docs.last;
        final color = ProductColorModel.fromFireStore(colorDoc);

        return [];
      } else {
        return [];
      }
    } catch (e) {
      handleException(e);
      return [];
    }
  }

  Future<List<ProductSizeModel>> fetchCategoryAndSizes(Product product) async {
    try {
      log(
        "\n STARTING FETCH FOR PRODUCT: ${product.name} (Category: ${product.categoryName})",
      );

      // Fetch category
      final categoryQuerySnapshot =
          await FirebaseFirestore.instance
              .collection(categoriesCollection)
              .where('name', isEqualTo: product.categoryName)
              .limit(1)
              .get();

      if (categoryQuerySnapshot.docs.isNotEmpty) {
        final categoryDoc = categoryQuerySnapshot.docs.first;
        final category = CategoryModel.fromFirestore(categoryDoc);

        log(
          "Main category fetched. ID: ${category.id}, Name: ${category.name}",
        );

        // Fetch product_size subcollection
        final productSizeSnapshot =
            await FirebaseFirestore.instance
                .collection(categoriesCollection)
                .doc(category.id)
                .collection('product_size')
                .get();

        if (productSizeSnapshot.docs.isNotEmpty) {
          // convert all docs to ProductSizeModel list
          final sizes =
              productSizeSnapshot.docs
                  .map((doc) => ProductSizeModel.fromFirestore(doc))
                  .toList();

          log("Successfully fetched ${sizes.length} size document(s)");
          return sizes;
        } else {
          log(
            "NO DOCUMENTS FOUND in 'product_size' for category ID: ${category.id}",
          );
          return []; // return empty list if nothing found
        }
      } else {
        log("NO CATEGORY FOUND for name: ${product.categoryName}");
        return []; // No category matched
      }
    } catch (e) {
      log("CRITICAL UNHANDLED ERROR during fetch: $e");
      return []; // Return empty list on error
    } finally {
      log("FETCH COMPLETED");
    }
  }
}
