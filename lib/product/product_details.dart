import 'package:flutter/material.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';

import '../cart/cart_page.dart';
import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../widgets/custom_chips.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  static const route = "product_details";

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  //for highlight the selected size
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey, width: 1),
          borderRadius: BorderRadius.only(
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

              SizedBox(width: 32),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(220, 50),
                        // textStyle: TextStyle(height: 0.8),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, CartPage.route);
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Icon(Icons.shopping_bag_rounded, size: 20),
                          ),
                          SizedBox(width: 10),
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
          // SliverAppBar(
          //   centerTitle: true,
          //   pinned: true,
          //   actions: [
          //     Padding(
          //       padding: const EdgeInsets.all(8),
          //       child: CircleAvatar(
          //         radius: 20,
          //         backgroundColor: Colors.white,
          //         child: IconButton(
          //           icon: Icon(Icons.favorite_border),
          //           onPressed: () {},
          //         ),
          //       ),
          //     ),
          //   ],
          //   title: Text(
          //     context.loc.productDetails,
          //     style: TTextTheme.lightTextTheme.headlineSmall?.copyWith(
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          //   backgroundColor: AppColors.cream,
          //   leading: Padding(
          //     padding: const EdgeInsets.all(8),
          //     child: CircleAvatar(
          //       backgroundColor: Colors.white,
          //       child: IconButton(
          //         icon: Icon(Icons.arrow_back, color: Colors.black),
          //         onPressed: () => Navigator.pop(context),
          //       ),
          //     ),
          //   ),
          // ),
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
                              icon: Icon(Icons.arrow_back, color: Colors.black),
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
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {
                                // Your favorite action
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

                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Icon(
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

                    Divider(
                      thickness: 1,
                      color: Colors.black12,
                      endIndent: 16,
                      indent: 16,
                      height: 28,
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 2),
                          child: Text(
                            context.loc.selectSize,
                            style: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 4),
                          CustomChips(
                            onTap:
                                () => setState(() {
                                  selectedSize = "S";
                                }),
                            label: Text(
                              "S",
                              style: TTextTheme.lightTextTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    // height: -0.8,
                                    color:
                                        selectedSize == "S"
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                            ),
                            backgroundColor:
                                selectedSize == "S"
                                    ? AppColors.brown
                                    : Colors.white,
                            height: 32,
                          ),
                          CustomChips(
                            onTap:
                                () => setState(() {
                                  selectedSize = "M";
                                }),
                            label: Text(
                              "M",
                              style: TTextTheme.lightTextTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    // height: -0.8,
                                    color:
                                        selectedSize == "M"
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                            ),
                            backgroundColor:
                                selectedSize == "M"
                                    ? AppColors.brown
                                    : Colors.white,
                            height: 32,
                          ),
                          CustomChips(
                            onTap:
                                () => setState(() {
                                  selectedSize = "L";
                                }),
                            label: Text(
                              "L",
                              style: TTextTheme.lightTextTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    // height: -0.8,
                                    color:
                                        selectedSize == "L"
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                            ),
                            backgroundColor:
                                selectedSize == "L"
                                    ? AppColors.brown
                                    : Colors.white,
                            height: 32,
                          ),

                          CustomChips(
                            onTap:
                                () => setState(() {
                                  selectedSize = "XL";
                                }),
                            label: Text(
                              "XL",
                              style: TTextTheme.lightTextTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    // height: -0.8,
                                    color:
                                        selectedSize == "XL"
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                            ),
                            backgroundColor:
                                selectedSize == "XL"
                                    ? AppColors.brown
                                    : Colors.white,
                            height: 32,
                          ),
                          // SizedBox(width: 8),
                          CustomChips(
                            onTap:
                                () => setState(() {
                                  selectedSize = "XXL";
                                }),
                            label: Text(
                              "XXL",
                              style: TTextTheme.lightTextTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    // height: -0.9,
                                    color:
                                        selectedSize == "XXL"
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                            ),
                            backgroundColor:
                                selectedSize == "XXL"
                                    ? AppColors.brown
                                    : Colors.white,
                            height: 32,
                          ),
                          // SizedBox(width: 14),
                          CustomChips(
                            onTap:
                                () => setState(() {
                                  selectedSize = "XXXL";
                                }),
                            label: Text(
                              "XXXL",
                              style: TTextTheme.lightTextTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    // height: -0.9,
                                    color:
                                        selectedSize == "XXXL"
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                            ),
                            backgroundColor:
                                selectedSize == "XXXL"
                                    ? AppColors.brown
                                    : Colors.white,
                            height: 32,
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 2),
                          child: Text(
                            context.loc.selectColor,
                            style: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 16),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.brown,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cream,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.creamColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightBrown,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightYellow,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
