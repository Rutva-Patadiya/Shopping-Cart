import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';

import '../product/bloc/filter_product_bloc.dart';
import '../product/bloc/filter_product_event.dart';
import '../product/category_list.dart';
import '../product/data/datasources/product_data_sources.dart';
import '../product/product_gridview.dart';
import '../widgets/custom_textfield.dart';

//Shows Home page when we successfully logged in
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/Home';

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // String selectedCategory = "All";

  TextEditingController searchController = TextEditingController();
  bool _isInitialized = false;
  final dataSources = ProductDataSources();

  @override
  void initState() {
    super.initState();

    // searchController.addListener(() {
    //   setState(() {});
    //   final query = searchController.text;
    //   log(
    //     "UI Dispatching ProductSearchedEvent with query: '$query', category: 'All'",
    //   );
    //
    //   context.read<ProductBloc>().add(ProductSearchedEvent(query, "All"));
    // });

    //addPostFrameCallback means it will call something when the whole UI is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        context.read<ProductBloc>().add(InitialProductLoaded());
        context.read<CategoryBloc>().add(CategoryLoadedEvent());
        _isInitialized = true;
      }
    });
  }

  //for highlight the button which is selected
  // void onCategoryChanged(String category) {
  //   final query = searchController.text;
  //   context.read<ProductBloc>().add(ProductSearchedEvent(query, category));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      prefixIcon: Icon(
                        Icons.search,
                        size: 32,
                        color: AppColors.brown,
                      ),
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
                      hintText: context.loc.searchHint,
                    ),
                    obscureText: false,

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
                  context.loc.categories,
                  style: TTextTheme.lightTextTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Shows the list of categories dynamically
          CategoryList(),
          // SizedBox(height: 16),

          // Shows the list of products in grid view
          Expanded(
            child: ProductGridView(),
            // child: BlocBuilder<ProductBloc, ProductState>(
            //   builder: (context, state) {
            //     log("State received: $state");
            //     // log(context as String);
            //     if (state is ProductLoadInProgress) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (state is ProductLoadSuccess) {
            //       final products = state.filteredProducts;
            //       return GridView.builder(
            //         padding: const EdgeInsets.all(12),
            //         gridDelegate:
            //             const SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 2,
            //               mainAxisSpacing: 16,
            //               crossAxisSpacing: 16,
            //               childAspectRatio: 0.7,
            //             ),
            //         itemCount: products.length,
            //         itemBuilder: (context, index) {
            //           return ProductCard(product: products[index]);
            //         },
            //       );
            //     } else if (state is ProductLoadFailure) {
            //       return Center(child: Text(state.message));
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
