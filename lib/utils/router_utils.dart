import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/favorite_page/favorite_page.dart';
import 'package:shopping_cart/product/bloc/product_bloc.dart';

import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../product/data/datasources/product_data_sources.dart';
import '../product/data/repositories/product_repositories_impl.dart';
import '../product/domain/entities/product.dart';
import '../product/product_details.dart';
import '../product/product_page.dart';
import '../signup/signup_page.dart';

Route<dynamic> onGenerateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignupPage.route:
      return MaterialPageRoute(builder: (context) => SignupPage());

    case Login.route:
      return MaterialPageRoute(builder: (context) => Login());

    case ProductPage.route:
      return MaterialPageRoute(builder: (context) => ProductPage());

    case ProductDetailsPage.route:
      final product = routeSettings.arguments as Product;
      // final category = routeSettings.arguments as CategoryModel;
      return MaterialPageRoute(
        builder:
            (context) => BlocProvider(
              create:
                  (_) => ProductBloc(
                    productRepository: ProductRepositoryImpl(
                      ProductDataSources(),
                    ),
                  ),
              child: ProductDetailsPage(product: product),
            ),
      );

    case HomePage.route:
      return MaterialPageRoute(builder: (context) => HomePage());

    case CartPage.route:
      return MaterialPageRoute(builder: (context) => CartPage());

    case FavoritePage.route:
      return MaterialPageRoute(builder: (context) => FavoritePage());

    default:
      return MaterialPageRoute(builder: (context) => Login());
  }
}
