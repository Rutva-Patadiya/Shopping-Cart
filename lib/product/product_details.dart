import 'package:flutter/material.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import '../widgets/custom_chips.dart';

class ProductDetailsPage extends StatelessWidget {
  static const route = "product_details";

  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            title: Text(
              context.loc.productDetails,
              style: TTextTheme.lightTextTheme.headlineLarge,
            ),
            backgroundColor: AppColors.cream,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.cream),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 16),
                      child: Row(
                        children: [
                          Text(
                            context.loc.femaleStyle,
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
                                  product.rating.toString(),
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
                            product.name,
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
                        product.productDetails,
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
                          SizedBox(width: 8),
                          CustomChips(
                            label: Text(
                              "S",
                              style: TTextTheme.lightTextTheme.labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: -0.8,
                                  ),
                            ),
                            backgroundColor: Colors.white,
                            height: 32,
                            width: 32,
                          ),
                          CustomChips(
                            label: Text(
                              "M",
                              style: TTextTheme.lightTextTheme.labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: -0.8,
                                  ),
                            ),
                            backgroundColor: Colors.white,
                            height: 32,
                            width: 32,
                          ),

                          CustomChips(
                            label: Text(
                              "XL",
                              style: TTextTheme.lightTextTheme.labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: -0.8,
                                  ),
                            ),
                            backgroundColor: Colors.white,
                            height: 32,
                            width: 32,
                          ),
                          SizedBox(width: 8),
                          CustomChips(
                            label: Text(
                              "XXL",
                              style: TTextTheme.lightTextTheme.labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: -0.8,
                                  ),
                            ),
                            backgroundColor: Colors.white,
                            height: 32,
                            width: 32,
                          ),
                          SizedBox(width: 12),
                          CustomChips(
                            label: Text(
                              "XXXL",
                              style: TTextTheme.lightTextTheme.labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: -0.8,
                                  ),
                            ),
                            backgroundColor: Colors.white,
                            height: 32,
                            width: 32,
                          ),
                        ],
                      ),
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
