import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/bloc/add_to_cart_bloc.dart';
import '../cart/bloc/add_to_cart_state.dart';
import '../cart/cart_page.dart';
import '../core/utils/theme/text_theme.dart';
import '../product/bloc/filter_product_bloc.dart';
import '../product/bloc/filter_product_event.dart';
import '../product/bloc/filter_product_state.dart';
import '../product/product_list.dart';
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

  @override
  void initState() {
    super.initState();
    //for searching feature in text field
    //called everytime when the text is written or changed
    searchController.addListener(() {
      setState(() {});
      String query = searchController.text;

      context.read<ProductBloc>().add(SearchProduct(query, selectedCategory));
    });

    //addPostFrameCallback means it will call something when the whole UI is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(LoadInitialProducts());
    });
  }

  //for highlight the button which is selected
  void onCategoryChanged(String category) {
    setState(() {
      selectedCategory = category;
    });
    context.read<ProductBloc>().add(FilterProducts(selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: CustomTextField(
                      label: null,
                      keyboardType: TextInputType.name,
                      hint: "Enter Product",
                      hintStyle: TTextTheme.lightTextTheme.titleSmall,
                      obscureText: false,
                      controller: searchController,
                      prefixIcon: Icons.search,
                      suffixIcon:
                          searchController.text.isNotEmpty
                              ? IconButton(
                                onPressed: () {
                                  searchController.clear();
                                },
                                icon: Icon(Icons.clear, size: 20),
                              )
                              : null,
                      validator: null,
                      // width: null,
                    ),
                  ),
                ),

                BlocBuilder<AddToCartBloc, AddToCartState>(
                  builder: (context, state) {
                    int count = 0;
                    bool isGreater = false;

                    if (state is CartLoaded) {
                      count = state.cartItems.length;
                      isGreater = count > 9;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, CartPage.route);
                              },

                              child: Icon(
                                Icons.shopping_cart_outlined,
                                size: 32,
                              ),
                            ),
                          ),
                          if (count > 0)
                            Positioned(
                              top: 4,
                              right: 4,
                              // bottom: 4,
                              child: Badge(
                                // backgroundColor: Colors.re,
                                label: Text(
                                  isGreater ? '9+' : '$count',
                                  style: TextTheme.of(context).labelSmall
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                // GestureDetector(child: CircleAvatar()),
              ],
            ),
          ),

          SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ActionChip(
                    backgroundColor: Colors.white,
                    label: Text("All"),
                    onPressed: () {
                      onCategoryChanged("All");
                    },
                  ),
                  ActionChip(
                    backgroundColor: Colors.white,
                    label: Text(""),
                    onPressed: () {
                      onCategoryChanged("Electronic");
                    },
                  ),
                  ActionChip(
                    backgroundColor: Colors.white,
                    label: Text("Clothing"),
                    onPressed: () {
                      onCategoryChanged("Clothing");
                    },
                  ),

                  // CustomButton(
                  //   name: "All",
                  //   isSelected: selectedCategory == "All",
                  //   onPressed: () {
                  //     _onCategoryChanged("All");
                  //   },
                  // ),
                  // CustomButton(
                  //   name: "Electronic",
                  //   isSelected: selectedCategory == "Electronic",
                  //   onPressed: () {
                  //     _onCategoryChanged("Electronic");
                  //   },
                  // ),
                ],
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  final products = state.filteredProducts;
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 6),
                    itemCount: products.length,
                    itemBuilder:
                        (context, index) => ProductList(
                          product: products[index],
                        ), //after converting the products in the list it can be accessed using an index number
                  );
                } else if (state is ProductError) {
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
