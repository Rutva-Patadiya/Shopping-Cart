import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../login/login_page.dart';
import '../signup/signup_page.dart';

Route<dynamic> onGenerateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignupPage.route:
      return MaterialPageRoute(builder: (context) => SignupPage());

    case Login.route:
      return MaterialPageRoute(builder: (context) => Login());

    // case ProductList.route:
    //   return MaterialPageRoute(builder: (context) => ProductList());

    // case Product.route:
    //   return MaterialPageRoute(builder: (context) => HomePage());

    case HomePage.route:
      return MaterialPageRoute(builder: (context) => HomePage());

    // case AddProductPage.route:
    //   return MaterialPageRoute(builder: (context) => AddProductPage());

    default:
      return MaterialPageRoute(builder: (context) => SignupPage());
  }
}
