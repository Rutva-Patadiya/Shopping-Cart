import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

import '../cart/bloc/add_to_cart_bloc.dart';
import '../cart/bloc/add_to_cart_event.dart';
import 'domain/entities/product.dart';

class ProductList extends StatelessWidget {
  final Product product;

  const ProductList({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: ListTile(
        tileColor: AppColors.lGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        leading:
            product.imageUrl.endsWith(".svg")
                ? SvgPicture.network(
                  product.imageUrl,
                  width: 40,
                  height: 40,
                  placeholderBuilder: (context) => CircularProgressIndicator(),
                )
                : Image.network(
                  product.imageUrl,
                  width: 40,
                  height: 40,
                  // fit: BoxFit.cover,
                ),
        title: Text(
          product.name,
          style: TTextTheme.lightTextTheme.headlineLarge,
        ),
        subtitle: Text(product.category),
        trailing: SizedBox(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\₹${product.price}',
                style: TTextTheme.lightTextTheme.headlineSmall,
              ),

              SizedBox(height: 4),
              ElevatedButton(
                onPressed:
                    () => {
                      context.read<AddToCartBloc>().add(AddToCart(product)),
                    },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(24, 24),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Add ",
                  style: TTextTheme.lightTextTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
