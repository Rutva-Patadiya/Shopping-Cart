import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();

    //addPostFrameCallback means it will call something when the whole UI is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(LoadInitialProducts());
    });
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
                CustomTextField(
                  label: null,
                  keyboardType: TextInputType.name,
                  hint: "Enter Product",
                  hintStyle: TTextTheme.lightTextTheme.titleSmall,
                  obscureText: false,
                  controller: SearchController(),
                  prefixIcon: Icons.search,
                  suffixIcon: null,
                  validator: null,
                  width: 330,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 18),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CartPage.route);
                    },
                    color: Colors.black,
                    icon: Icon(Icons.shopping_cart_outlined, size: 34),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomButton(
                  name: "All",
                  onPressed: () {
                    context.read<ProductBloc>().add(FilterProducts("All"));
                  },
                ),
                CustomButton(
                  name: "Electronic",
                  onPressed: () {
                    context.read<ProductBloc>().add(
                      FilterProducts("Electronic"),
                    );
                  },
                ),
                CustomButton(
                  name: "Clothing",
                  onPressed: () {
                    context.read<ProductBloc>().add(FilterProducts("Clothing"));
                  },
                ),
                CustomButton(
                  name: "Grocery",
                  onPressed: () {
                    context.read<ProductBloc>().add(FilterProducts("Grocery"));
                  },
                ),
              ],
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
                        (context, index) =>
                            ProductList(product: products[index]),
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

  const CustomButton({super.key, required this.name, required this.onPressed});

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
          onPressed: () {
            onPressed();
          },
          child: Text(name),
        ),
      ),
    );
  }
}
