import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';
import 'package:shopping_cart/widgets/custom_action_chip.dart';

import '../product/bloc/filter_product_bloc.dart';
import '../product/bloc/filter_product_event.dart';
import '../product/bloc/filter_product_state.dart';
import '../product/category_icon_list.dart';
import '../product/data/datasources/product_data_sources.dart';
import '../product/product_card.dart';
import '../widgets/custom_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/Home';

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String selectedCategory = "All";
  int currentIndex = 0;
  TextEditingController searchController = TextEditingController();

  final dataSources = ProductDataSources();

  @override
  void initState() {
    super.initState();
    //for searching feature in text field
    //called everytime when the text is written or changed
    searchController.addListener(() {
      setState(() {});
      String query = searchController.text;

      context.read<ProductBloc>().add(
        ProductSearchedEvent(query, selectedCategory),
      );
    });

    //addPostFrameCallback means it will call something when the whole UI is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(InitialProductLoaded());
    });
  }

  //for highlight the button which is selected
  void onCategoryChanged(String category) {
    setState(() {
      selectedCategory = category;
    });
    context.read<ProductBloc>().add(ProductFilteredEvent(selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: TAppTheme.lightTheme.colorScheme.background,
      body: Column(
        children: [
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Icon(Icons.search, size: 20),
                      suffixIcon:
                          searchController.text.isNotEmpty
                              ? IconButton(
                                onPressed: () {
                                  searchController.clear();
                                },
                                icon: Icon(Icons.clear, size: 20),
                              )
                              : null,
                      hintStyle: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(color: Colors.brown, width: 2),
                      ),
                    ),
                    obscureText: false,

                    validator: null,
                    // width: null,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          Container(
            margin:
                EdgeInsets.symmetric(horizontal: 16, vertical: 4).copyWith(),
            child: Row(
              children: [
                Text(
                  "Category",
                  style: TTextTheme.lightTextTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          CategoryIcon(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CategoryChips(
                onCategoryChanged: (selectedCategory) {
                  context.read<ProductBloc>().add(
                    ProductFilteredEvent(selectedCategory),
                  );
                },
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoadInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoadSuccess) {
                  final products = state.filteredProducts;
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
                } else if (state is ProductLoadFailure) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
//
// Expanded(
// child: BlocBuilder<ProductBloc, ProductState>(
// builder: (context, state) {
// if (state is ProductLoadInProgress) {
// return const Center(child: CircularProgressIndicator());
// } else if (state is ProductLoadSuccess) {
// final products = state.filteredProducts;
// return ListView.builder(
// padding: EdgeInsets.only(top: 6),
// itemCount: products.length,
// itemBuilder:
// (context, index) => ProductList(
// product: products[index],
// ), //after converting the products in the list it can be accessed using an index number
// );
// } else if (state is ProductLoadFailure) {
// return Center(child: Text(state.message));
// }
// return const SizedBox.shrink();
// },
// ),
// ),
// BlocBuilder<AddToCartBloc, AddToCartState>(
//   builder: (context, state) {
//     int count = 0;
//     bool isGreater = false;
//
//     if (state is CartLoaded) {
//       count = state.cartItems.length;
//       isGreater = count > 9;
//     }

// return Padding(
//   padding: const EdgeInsets.only(top: 22),
//   child: Stack(
//     children: [
//       Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         child: InkWell(
//           onTap: () {
//             Navigator.pushNamed(context, CartPage.route);
//           },
//
//           child: Icon(
//             Icons.shopping_cart_outlined,
//             size: 32,
//           ),
//         ),
//       ),
//       if (count > 0)
//         Positioned(
//           top: 4,
//           right: 4,
//           // bottom: 4,
//           child: Badge(
//             // backgroundColor: Colors.re,
//             label: Text(
//               isGreater ? '9+' : '$count',
//               style: TextTheme.of(context).labelSmall
//                   ?.copyWith(fontWeight: FontWeight.w400),
//             ),
//           ),
//         ),
//     ],
//   ),
// );
//       },
//     ),
//     // GestureDetector(child: CircleAvatar()),
