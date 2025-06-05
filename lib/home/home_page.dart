import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';

import '../core/utils/theme/text_theme.dart';
import '../product/bloc/product_bloc.dart';
import '../product/bloc/product_event.dart';
import '../product/category_list.dart';
import '../product/data/datasources/product_data_sources.dart';
import '../widgets/carousel_images.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/filter_button.dart';
import '../widgets/location_service.dart';
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

  Placemark? placeMark; //for fetching human readable location
  bool _isInitialized = false;
  final dataSources = ProductDataSources();

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
        _isInitialized = true;
        _getCurrentLocation(); //when the UI is ready,it will fetch location
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();

      if (!mounted) return;

      //convert raw location(lat,lng) to human readable
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position?.latitude ?? 0.0,
        position?.longitude ?? 0.0,
      );

      setState(() {
        placeMark = placeMarks.isEmpty ? null : placeMarks.first;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // Location Display
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22, top: 16),
                        child: Text(
                          placeMark == null
                              ? 'Fetching location...'
                              : '${placeMark!.name}',
                          style: TTextTheme.lightTextTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(g
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        placeMark == null
                            ? 'Fetching location...'
                            : ' ${placeMark!.subLocality} ${placeMark!.locality}, ${placeMark!.administrativeArea}, ${placeMark!.postalCode}, ${placeMark!.country}',
                        style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Sticky Search Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickySearchBarDelegate(searchController),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
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
            ),
            // Sticky Category List
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyCategoryDelegate(),
            ),

            // Carousel Images
            SliverToBoxAdapter(child: CarouselImages()),

            // Product GridView
            SliverToBoxAdapter(child: ProductGridView()),
          ],
        ),
      ),
    );
  }
}

class _StickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;

  _StickySearchBarDelegate(this.searchController);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
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
                                  // Reload all products on clear
                                  context.read<ProductBloc>().add(
                                    InitialProductLoaded(),
                                  );
                                },
                                icon: Icon(Icons.clear, size: 20),
                              )
                              : null,
                      hintText: context.loc.searchHint,
                      hintStyle: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
                        color: Colors.black45,
                      ),
                    ),
                    obscureText: false,
                  ),
            ),
          ),
          FilterButton(),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _StickyCategoryDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: const CategoryList(),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
