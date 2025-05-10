import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_product_event.dart';
import 'filter_product_state.dart';

class Product {
  final String name;
  final String category;
  final int price;
  final String imageUrl;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromFirestore(Map<String, dynamic> data) {
    return Product(
      name: data['Name'] ?? '',
      category: data['Category'] ?? '',
      price: data['Price'] ?? 0,
      imageUrl: data['Image'] ?? '',
    );
  }
}

Future<List<Product>> fetchProducts() async {
  // it fetches documents from Firebase
  final snapshot =
      await FirebaseFirestore.instance.collection('products').get();
  // loops over each document, and for every document, it calls
  // docs:property of snapshot & give list of all the product documents Each doc contains fields like Name..
  return snapshot.docs.map((doc) => Product.fromFirestore(doc.data())).toList();
}

class ProductBloc extends Bloc<ProductFilterEvent, ProductState> {
  List<Product> allProducts = [];

  ProductBloc() : super(ProductLoading()) {
    on<FilterProducts>((event, emit) async {
      emit(ProductLoading());

      try {
        allProducts = await fetchProducts(); // from your original code

        if (event.category == "All") {
          emit(ProductLoaded(allProducts));
        } else {
          final filtered =
              allProducts
                  .where((product) => product.category == event.category)
                  .toList();

          emit(ProductLoaded(filtered));
        }
      } catch (e) {
        emit(ProductError('Failed to fetch products: $e'));
      }
    });
  }
}
