import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/product/bloc/filter_product_bloc.dart';
import 'package:shopping_cart/product/bloc/filter_product_event.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/data/repositories/product_repositories_impl.dart';
import 'package:shopping_cart/signup/signup_page.dart';
import 'package:shopping_cart/utils/router_utils.dart';

import 'core/utils/theme/theme.dart';
import 'login/bloc/auth_bloc.dart';

Future<void> main() async {
  //ensure flutter sets up
  WidgetsFlutterBinding.ensureInitialized();
  //initialize the firebase sdk (storage,authentication and all
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
        // immediately sends a LoadProducts event to the bloc right after it's created,
        BlocProvider<ProductBloc>(
          create:
              (_) =>
                  ProductBloc(ProductRepositoryImpl(ProductDataSources()))
                    ..add(LoadProducts()),
        ),
        // BlocProvider(create: (_) =>)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Page',
        theme: TAppTheme.lightTheme,
        onGenerateRoute: onGenerateRoutes,
        // Apply current locale
        home: SignupPage(),
      ),
    );
  }
}
