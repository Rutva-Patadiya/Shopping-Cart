import 'package:flutter/material.dart';

import '../cart/cart_page.dart';
import '../login/login_page.dart';
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

    case CartPage.route:
      return MaterialPageRoute(builder: (context) => CartPage());

    // case HomePage.route:
    //   return MaterialPageRoute(builder: (context) => HomePage());

    // case AddProductPage.route:
    //   return MaterialPageRoute(builder: (context) => AddProductPage());

    default:
      return MaterialPageRoute(builder: (context) => SignupPage());
  }
}
