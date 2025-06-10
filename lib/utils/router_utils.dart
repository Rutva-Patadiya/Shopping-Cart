import 'package:flutter/material.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';

import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
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
      return MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      );

    case HomePage.route:
      return MaterialPageRoute(builder: (context) => HomePage());

    case CartPage.route:
      return MaterialPageRoute(builder: (context) => CartPage());

    // case AddProductPage.route:
    //   return MaterialPageRoute(builder: (context) => AddProductPage());

    default:
      return MaterialPageRoute(builder: (context) => Login());
  }
}
