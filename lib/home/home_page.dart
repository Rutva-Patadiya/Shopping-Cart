import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/widgets/dropdown_button.dart';

import '../product/bloc/filter_product_bloc.dart';
import '../product/bloc/filter_product_event.dart';
import '../product/category_list.dart';
import '../product/data/datasources/product_data_sources.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/filter_button.dart';
import '../widgets/product_gridview.dart';

//Shows Home page when we successfully logged in
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/Home';

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  bool _isInitialized = false;
  final dataSources = ProductDataSources();
  String selectedValue = "New York, USA";

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      final query = searchController.text;
      log("Event: Product Searched event");
      context.read<ProductBloc>().add(ProductSearchedEvent(query));
    });

    //addPostFrameCallback means it will call something when the whole UI is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        context.read<ProductBloc>().add(InitialProductLoaded());
        context.read<CategoryBloc>().add(CategoryLoadedEvent());
        _isInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(top: 56, left: 24),
            child: Row(
              children: [
                Text(
                  context.loc.location,
                  style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // //DropDown Button for location selection
          DropDownButton(),

          SizedBox(height: 12),

          //custom search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Container(
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: searchController,
                    builder:
                        (context, value, child) => CustomTextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 28,
                              color: AppColors.brown,
                            ),
                            suffixIcon:
                                searchController.text.isNotEmpty
                                    ? IconButton(
                                      onPressed: () {
                                        searchController.clear();

                                        //reload all products after clearing search
                                        context.read<ProductBloc>().add(
                                          InitialProductLoaded(),
                                        );
                                      },
                                      icon: Icon(Icons.clear, size: 20),
                                    )
                                    : null,
                            hintStyle: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(color: Colors.black45),
                            hintText: context.loc.searchHint,
                          ),
                          obscureText: false,

                          // width: null,
                        ),
                  ),
                ),

                //filter button
                FilterButton(),
              ],
            ),
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

          SizedBox(height: 8),

          // Shows the list of categories dynamically
          CategoryList(),

          // Shows the list of products in grid view
          Expanded(child: ProductGridView()),
        ],
      ),
    );
  }
}
