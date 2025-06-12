import 'package:flutter/material.dart';
import 'package:shopping_cart/favorite_page/favorite_page.dart';

import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../product/data/models/category_model.dart';
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
            (context) =>
                ProductDetailsPage( product: product),
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
