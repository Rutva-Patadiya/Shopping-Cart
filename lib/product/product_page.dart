import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/cart/bloc/add_to_cart_bloc.dart';
import 'package:shopping_cart/cart/bloc/add_to_cart_state.dart';
import 'package:shopping_cart/product/product_list.dart';

import '../cart/cart_page.dart';
import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../signup/signup_page.dart';
import 'bloc/filter_product_bloc.dart';
import 'bloc/filter_product_event.dart';
import 'bloc/filter_product_state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  static const route = '/product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedCategory = "All";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //for searching feature in text field
    //called everytime when the text is written or changed
    searchController.addListener(() {
      String query = searchController.text;

      context.read<ProductBloc>().add(SearchProduct(query, selectedCategory));
    });

    //addPostFrameCallback means it will call something when the whole UI is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(LoadInitialProducts());
    });
  }

  //for highlight the button which is selected
  void _onCategoryChanged(String category) {
    setState(() {
      //when category is changed then text field should be clear
      // searchController.clear();
      selectedCategory = category;
    });
    context.read<ProductBloc>().add(FilterProducts(selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
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
                      suffixIcon: null,
                      validator: null,
                      width: null,
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
                  CustomButton(
                    name: "All",
                    isSelected: selectedCategory == "All",
                    onPressed: () {
                      _onCategoryChanged("All");
                    },
                  ),
                  CustomButton(
                    name: "Electronic",
                    isSelected: selectedCategory == "Electronic",
                    onPressed: () {
                      _onCategoryChanged("Electronic");
                    },
                  ),
                  CustomButton(
                    name: "Clothing",
                    isSelected: selectedCategory == "Clothing",
                    onPressed: () {
                      _onCategoryChanged("Clothing");
                    },
                  ),
                  CustomButton(
                    name: "Grocery",
                    isSelected: selectedCategory == "Grocery",
                    onPressed: () {
                      _onCategoryChanged("Grocery");
                    },
                  ),
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

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool isSelected;

  const CustomButton({
    super.key,
    required this.name,
    required this.onPressed,
    required this.isSelected, //to check whether that button is selected or not
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            backgroundColor: isSelected ? AppColors.bgAccent : AppColors.grey,
            // Override background color
            foregroundColor: isSelected ? Colors.white : Colors.black,
            // Override text/icon color
            minimumSize: Size(30, 40),
            // Override size
            textStyle: TextStyle(
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          ),
          onPressed: () {
            onPressed();
          },
          child: Text(name),
        ),
      ),
    );
  }
}
