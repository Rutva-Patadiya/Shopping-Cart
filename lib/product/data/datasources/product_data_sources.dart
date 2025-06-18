import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';
import 'package:shopping_cart/utils/firebase_utils.dart';

import '../models/category_model.dart'; // import '../models/product_color_model.dart';
import '../models/product_color_model.dart';
import '../models/product_model.dart';
import '../models/product_size_model.dart';

// This class fetches data from Firebase Fire store, which contains the product details.
class ProductDataSources {
  static const productCollection = "products";
  static const categoriesCollection = "categories";
  static const variantsCollection = "variants";

  late Product product;
  late CategoryModel categoryModel;
  late ProductSizeModel productSizeModel;

  //Fetches the products from the firebase
  Future<List<ProductModel>> fetchProducts() async {
    final productSnapshot = await FirebaseFirestore.instance
        .collection(productCollection)
        .get()
        .handleFirebase(logName: "fetchProducts");

    if (productSnapshot == null || productSnapshot.docs.isEmpty) {
      return [];
    }
    return productSnapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();
  }

  //Fetches the categories from the firebase
  Future<List<CategoryModel>> fetchCategories() async {
    final categorySnapshot = await FirebaseFirestore.instance
        .collection(categoriesCollection)
        .get()
        .handleFirebase(logName: "fetchCategories");

    if (categorySnapshot == null || categorySnapshot.docs.isEmpty) {
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
  }

  Future<List<ProductColorModel>> fetchColors(String productId) async {
    //retrieves the reference of the document
    final productRef = FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productId);

    final querySnapshot = await FirebaseFirestore.instance
        .collection(variantsCollection)
        .where('product_id', isEqualTo: productRef)
        .where('name', isEqualTo: 'Color') //  fetch only color variant
        .limit(1)
        .get()
        .handleFirebase(logName: "fetchColors");

    if (querySnapshot == null || querySnapshot.docs.isEmpty) return [];

    return querySnapshot.docs
        .map((doc) => ProductColorModel.fromFirestore(doc))
        .toList();
  }

  Future<List<ProductSizeModel>> fetchSizes(String productId) async {
    //fetch the document id of the collection
    final productRef = FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productId);

    //fetch the document inside variants where product_id matched
    final querySnapshot = await FirebaseFirestore.instance
        .collection(variantsCollection)
        .where('product_id', isEqualTo: productRef)
        .where('name', isEqualTo: 'Size')
        .limit(1)
        .get()
        .handleFirebase(logName: "fetchSizes");

    if (querySnapshot == null || querySnapshot.docs.isEmpty) return [];

    return querySnapshot.docs
        .map((doc) => ProductSizeModel.fromFirestore(doc))
        .toList();
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

  // Future<List<ProductColorModel>> fetchColors(Product product) async {
  //   log("Fetching colors for product: ${product.name}");
  //
  //   final categoryQuery = await FirebaseFirestore.instance
  //       .collection(categoriesCollection)
  //       .where('name', isEqualTo: product.categoryName)
  //       .limit(1)
  //       .get()
  //       .handleFirebase(logName: "fetchColors");
  //
  //   if (categoryQuery == null || categoryQuery.docs.isEmpty) {
  //     log("No category found for ${product.categoryName}");
  //     return [];
  //   }
  //
  //   final categoryDoc = categoryQuery.docs.first;
  //
  //   final colorCollection = await FirebaseFirestore.instance
  //       .collection(categoriesCollection)
  //       .doc(categoryDoc.id)
  //       .collection('product_color')
  //       .get()
  //       .handleFirebase(logName: "fetchColors");
  //
  //   if (colorCollection == null || colorCollection.docs.isEmpty) {
  //     log("No color documents found");
  //     return [];
  //   }
  //
  //   final colors =
  //       colorCollection.docs.map((doc) {
  //         final data = doc.data();
  //
  //         // Extract color array directly
  //         final List<String> colorList =
  //             (data['color'] as List<dynamic>).cast<String>();
  //
  //         log("final array: $colorList");
  //         return ProductColorModel(id: doc.id, colors: colorList);
  //       }).toList();
  //
  //   log("Successfully fetched ${colors.length} color document(s)");
  //   return colors;
  // }

  // Future<List<ProductColorModel>> fetchColors(Product product) async {
  //   try {
  //     log("Fetching colors for product: ${product.name}");
  //
  //     final colorSnapshot =
  //         await FirebaseFirestore.instance
  //             .collection(productColorCollection)
  //             .get();
  //
  //     return colorSnapshot.docs
  //         .map((doc) => ProductColorModel.fromFireStore(doc))
  //         .toList();
  //   } catch (e) {
  //     log("Error fetching colors: $e");
  //     return [];
  //   }
  // }

  //   Future<List<ProductSizeModel>?> fetchCategoryAndSizes(Product product) async {
  //     log(
  //       "\n STARTING FETCH FOR PRODUCT: ${product.name} (Category: ${product.categoryName})",
  //     );
  //
  //     // Fetch category
  //     final categoryQuerySnapshot = await FirebaseFirestore.instance
  //         .collection(categoriesCollection)
  //         .where('name', isEqualTo: product.categoryName)
  //         .limit(1)
  //         .get()
  //         .handleFirebase(logName: "fetchCategoryAndSizes");
  //
  //     if (categoryQuerySnapshot == null ||
  //         categoryQuerySnapshot.docs.isNotEmpty) {
  //       final categoryDoc = categoryQuerySnapshot?.docs.first;
  //       final category = CategoryModel.fromFirestore(
  //         categoryDoc as DocumentSnapshot<Object?>,
  //       );
  //
  //       log("Main category fetched. ID: ${category.id}, Name: ${category.name}");
  //
  //       // Fetch product_size subcollection
  //       final productSizeSnapshot = await FirebaseFirestore.instance
  //           .collection(categoriesCollection)
  //           .doc(category.id)
  //           .collection('product_size')
  //           .get()
  //           .handleFirebase(logName: "fetchCategoryAndSizes");
  //
  //       if (productSizeSnapshot == null || productSizeSnapshot.docs.isNotEmpty) {
  //         // convert all docs to ProductSizeModel list
  //         final sizes =
  //             productSizeSnapshot?.docs
  //                 .map((doc) => ProductSizeModel.fromFirestore(doc))
  //                 .toList();
  //
  //         log("Successfully fetched size document(s)");
  //         return sizes;
  //       } else {
  //         log(
  //           "NO DOCUMENTS FOUND in 'product_size' for category ID: ${category.id}",
  //         );
  //         return []; // return empty list if nothing found
  //       }
  //     } else {
  //       log("NO CATEGORY FOUND for name: ${product.categoryName}");
  //       return []; // No category matched
  //     }
  //   }
}
