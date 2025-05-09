import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

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

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: ListTile(
        tileColor: AppColors.lGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        leading:
            product.imageUrl.endsWith(".svg")
                ? SvgPicture.network(
                  product.imageUrl,
                  width: 40,
                  height: 40,
                  placeholderBuilder: (context) => CircularProgressIndicator(),
                )
                : Image.network(
                  product.imageUrl,
                  width: 40,
                  height: 40,
                  // fit: BoxFit.cover,
                ),
        title: Text(
          product.name,
          style: TTextTheme.lightTextTheme.headlineLarge?.copyWith(),
        ),
        subtitle: Text(product.category),
        trailing: Column(
          children: [
            Text(
              '\₹${product.price}',
              style: TTextTheme.lightTextTheme.headlineSmall,
            ),

            SizedBox(height: 4),
            ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(24, 24),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "Add ",
                style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // InkWell(
            //   customBorder: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   onTap: () => Text("On tap is pressed"),
            //   child: Text(
            //     "Add to Cart",
            //     style: TTextTheme.lightTextTheme.labelMedium?.copyWith(
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
