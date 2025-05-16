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

  // final List<Widget> _pages = [ProductPage(), CartPage(), ProfilePage()];
  // @override
  // void initState() {
  //   super.initState();
  //   //for searching feature in text field
  //   //called everytime when the text is written or changed
  //   searchController.addListener(() {
  //     setState(() {});
  //     String query = searchController.text;
  //
  //     context.read<ProductBloc>().add(SearchProduct(query, selectedCategory));
  //   });
  //
  //   //addPostFrameCallback means it will call something when the whole UI is loaded.
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<ProductBloc>().add(LoadInitialProducts());
  //   });
  // }
  //
  // //for highlight the button which is selected
  // void _onCategoryChanged(String category) {
  //   setState(() {
  //     selectedCategory = category;
  //   });
  //   context.read<ProductBloc>().add(FilterProducts(selectedCategory));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        height: 60,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: <Widget>[
          const NavigationDestination(icon: Icon(Icons.home), label: ''),

          const NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '',
          ),
          NavigationDestination(icon: const Icon(Icons.person), label: ''),
        ],
      ),

      body: <Widget>[HomePage(), CartPage(), ProfilePage()][currentIndex],
    );
  }
}
