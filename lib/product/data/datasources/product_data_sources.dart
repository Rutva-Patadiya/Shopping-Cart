import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

// This class fetches data from Firebase Firestore, which contains the product details.
class ProductDataSources {
  Future<List<ProductModel>> fetchProducts() async {
    // it fetches documents from Firebase
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    // loops over each document & docs:property of snapshot & give list of all the product documents Each doc contains fields like Name..
    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.data()))
        .toList();
  }

  // Future<List<ProductModel>>
}

//make constant file for collection of products so that when we change name of collection it should be changed vevrywhere
