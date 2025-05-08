import 'package:flutter/material.dart';
import 'package:shopping_cart/product/product_list.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../signup/signup_page.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  static const route = '/product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              label: null,
              keyboardType: TextInputType.name,
              hint: "Enter Product",
              hintStyle: TTextTheme.lightTextTheme.titleSmall,
              obscureText: false,
              controller: SearchController(),
              prefixIcon: Icons.search,
              suffixIcon: null,
              validator: null,
            ),
          ),

          SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomButton(name: "All"),
                CustomButton(name: "Electronic"),
                CustomButton(name: "Clothing"),
                CustomButton(name: "Grocery"),
              ],
            ),
          ),
          // Product list
          Expanded(
            child: ListView.builder(
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: allProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String name;

  const CustomButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.grey,
              // Override background color
              foregroundColor: Colors.black,
              // Override text/icon color
              minimumSize: Size(30, 40),
              // Override size
              textStyle: TextStyle(
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            ),
            onPressed: () {},
            child: Text(name),
          ),
        ),
      ],
    );
  }
}
