import 'package:flutter/material.dart';
import 'package:shopping_cart/home/home_page.dart';

import '../cart/cart_page.dart';
import '../profile_page/profile_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  static const route = '/product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // String selectedCategory = "All";
  TextEditingController searchController = TextEditingController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: <Widget>[HomePage(), CartPage(), ProfilePage()][currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home, index: 0),
              _buildNavItem(icon: Icons.shopping_bag_outlined, index: 1),
              _buildNavItem(icon: Icons.person, index: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24,
          color: isSelected ? Colors.brown : Colors.grey[400],
        ),
      ),
    );
  }
}
