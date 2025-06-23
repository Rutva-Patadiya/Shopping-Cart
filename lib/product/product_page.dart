import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/home/home_page.dart';

import '../cart/cart_page.dart';
import '../core/utils/theme/theme.dart';
import '../favorite_page/favorite_page.dart';
import '../message/message_page.dart';
import '../profile/profile_page.dart';
import 'bloc/product_bloc.dart';
import 'data/datasources/product_data_sources.dart';
import 'data/repositories/product_repositories_impl.dart';

//contains the page with bottom navigation bar
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  static const route = '/product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    // Initialize pages once
    pages = [
      MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create:
                (_) => ProductBloc(
                  productRepository: ProductRepositoryImpl(
                    ProductDataSources(),
                  ),
                ),
          ),
          BlocProvider(create: (_) => CategoryBloc()),
        ],
        child: HomePage(),
      ),
      CartPage(),
      FavoritePage(),
      MessagePage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 16, bottom: 16, right: 20, left: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(icon: Icons.home, index: 0),
            _buildNavItem(icon: Icons.shopping_bag_outlined, index: 1),
            _buildNavItem(icon: Icons.favorite_border_rounded, index: 2),
            _buildNavItem(icon: Icons.message_outlined, index: 3),
            _buildNavItem(icon: Icons.person_outline_outlined, index: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => currentIndex = index),
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
          color: isSelected ? AppColors.brown : Colors.white60,
        ),
      ),
    );
  }
}

// class _ProductPageState extends State<ProductPage> {
//   TextEditingController searchController = TextEditingController();
//   int currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true, //to make bottom navigation transparent
//       body:
//           <Widget>[
//             HomePage(),
//             CartPage(),
//             FavoritePage(),
//             MessagePage(),
//             ProfilePage(),
//           ][currentIndex],
//
//       bottomNavigationBar: Container(
//         // height: 64,
//         margin: EdgeInsets.only(top: 16, bottom: 16, right: 20, left: 20),
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(40),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildNavItem(icon: Icons.home, index: 0),
//             _buildNavItem(icon: Icons.shopping_bag_outlined, index: 1),
//             _buildNavItem(icon: Icons.favorite_border_rounded, index: 2),
//             _buildNavItem(icon: Icons.message_outlined, index: 3),
//             _buildNavItem(icon: Icons.person_outline_outlined, index: 4),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem({required IconData icon, required int index}) {
//     bool isSelected = currentIndex == index;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           currentIndex = index;
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.all(6),
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.white : Colors.transparent,
//           shape: BoxShape.circle,
//         ),
//         child: Icon(
//           icon,
//           size: 24,
//           color: isSelected ? AppColors.brown : Colors.white60,
//         ),
//       ),
//     );
//   }
