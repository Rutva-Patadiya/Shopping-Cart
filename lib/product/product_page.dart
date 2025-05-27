import 'package:flutter/material.dart';
import 'package:shopping_cart/home/home_page.dart';

import '../cart/cart_page.dart';
import '../core/utils/theme/theme.dart';
import '../profile_page/profile_page.dart';

//contains the page with bottom navigation bar
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
      extendBody: true, //to make bottom navigation transparent
      body: <Widget>[HomePage(), CartPage(), ProfilePage()][currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 24),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        margin: EdgeInsets.all(6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24,
          color: isSelected ? AppColors.brown : Colors.grey[400],
        ),
      ),
    );
  }
}
