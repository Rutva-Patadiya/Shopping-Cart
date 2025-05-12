import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductDataSources {
  Future<List<ProductModel>> fetchProducts() async {
    // it fetches documents from Firebase
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    // loops over each document, and for every document, it calls
    // docs:property of snapshot & give list of all the product documents Each doc contains fields like Name..
    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.data()))
        .toList();
  }
}
