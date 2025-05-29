import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_cart/login/login_page.dart';
import 'package:shopping_cart/product/bloc/filter_product_bloc.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/product/data/repositories/product_repositories_impl.dart';
import 'package:shopping_cart/utils/router_utils.dart';

import 'cart/bloc/add_to_cart_bloc.dart';
import 'core/utils/theme/theme.dart';
import 'login/bloc/auth_bloc.dart';
import 'login/bloc/auth_event.dart';

Future<void> main() async {
  //ensure flutter sets up
  WidgetsFlutterBinding.ensureInitialized();
  //initialize the firebase sdk (storage,authentication and all)
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()..add(AppStarted())),
        // immediately sends a LoadProducts event to the bloc right after it's created,
        BlocProvider<ProductBloc>(
          create:
              (_) => ProductBloc(ProductRepositoryImpl(ProductDataSources())),
        ),
        BlocProvider<CategoryBloc>(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => AddToCartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Page',
        theme: TAppTheme.lightTheme,
        onGenerateRoute: onGenerateRoutes,
        // Apply current locale
        home: Login(),

        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
        ],
      ),
    );
  }
}
