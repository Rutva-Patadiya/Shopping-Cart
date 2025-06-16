import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/favorite_page/favorite_page.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/product/bloc/product_event.dart';
import 'package:shopping_cart/product/bloc/product_state.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';
import 'package:shopping_cart/product/product_color_list.dart';
import 'package:shopping_cart/product/product_size_list.dart';

import '../cart/cart_page.dart';
import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import 'bloc/product_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  static const route = "product_details";

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    if (widget.product.categoryName == "Clothing") {
      context.read<ProductBloc>().add(ProductSizeLoaded(widget.product));
      context.read<ProductBloc>().add(ProductColorLoaded(widget.product));
    }
    // } else if (widget.product.categoryName == "Shoes" ||
    //     widget.product.categoryName == "Clothing") {
    //   // context.read<ProductBloc>().add(ProductColorLoaded(widget.product));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey, width: 1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 12),
                        child: Text(
                          context.loc.totalPrice,
                          style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
                            color: Colors.black54,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          "\$${widget.product.price.toString()} ",
                          style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(220, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, CartPage.route);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Icon(Icons.shopping_bag_rounded, size: 20),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            context.loc.addToCart,
                            textAlign: TextAlign.center,
                            style: TTextTheme.lightTextTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 0.5,
                                  letterSpacing: 0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 64,
                          left: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 64,
                          right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  FavoritePage.route,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 16),
                      child: Row(
                        children: [
                          Text(
                            widget.product.productContext,
                            style: TTextTheme.lightTextTheme.bodyMedium
                                ?.copyWith(color: Colors.black45),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                  size: 24,
                                ),
                                Text(
                                  widget.product.rating.toString(),
                                  style: TTextTheme.lightTextTheme.bodyMedium
                                      ?.copyWith(color: Colors.black38),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            widget.product.name,
                            style: TTextTheme.lightTextTheme.headlineSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            context.loc.productDetails,
                            style: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
                      child: Text(
                        widget.product.productDetails,
                        style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black12,
                      endIndent: 16,
                      indent: 16,
                      height: 28,
                    ),

                    if (widget.product.categoryName == "Clothing")
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductSizeLoadSuccess ) {
                            return ProductSizeList(
                              product: widget.product,
                              sizes: state.productSize,
                              sizeList: state.sizeList,
                            );
                          } else if (widget.product.categoryName !=
                              "Clothing") {
                            return const Center(
                              child: Text("Your category is not matched"),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductColorLoadSuccess) {
                            return ProductColorList(product:widget.product,colorList:state.colorList,color:state.productColor);

                          } else if (widget.product.categoryName !=
                              "Clothing") {
                            return const Center(
                              child: Text("Your category is not matched"),
                            );
                          }
                          else
                            {
                              return SizedBox();
                            }
                        },
                      ),
                      ],
                    ),
                  ],
                ),),
              ],
            )
    );
  }
}

