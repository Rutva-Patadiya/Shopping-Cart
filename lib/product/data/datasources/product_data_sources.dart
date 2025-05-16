import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

// This class fetches data from Firebase Firestore, which contains the product details.
class ProductDataSources {
  //need to define collectionname as const because when we change the name of collection it should be changed everywhere
  static const collectionName = "products";

  Future<List<ProductModel>> fetchProducts() async {
    // it fetches documents from Firebase
    final snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();
    // loops over each document & docs:property of snapshot & give list of all the product documents Each doc contains fields like Name..
    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.data()))
        .toList();
  }

  // Future<List<ProductModel>>
}
