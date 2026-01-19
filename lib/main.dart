import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_cart/login/login_page.dart';
import 'package:shopping_cart/product/data/datasources/product_data_sources.dart';
import 'package:shopping_cart/utils/router_utils.dart';

import 'core/observer/app_bloc_observer.dart';
import 'core/utils/theme/theme.dart';
import 'firebase_options_prod.dart';
import 'l10n/app_localizations.dart';
import 'login/bloc/auth_bloc.dart';
import 'login/bloc/auth_event.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    // Ensure Flutter bindings are initialized in the same zone as runApp
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // Catch all Flutter framework errors
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Set your Bloc observer
    Bloc.observer = AppBlocObserver();

    // Run the app
    runApp(const MyApp());
  }, (error, stack) {
    // Catch uncaught Dart errors
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });

  // Catch uncaught errors in other Dart threads / platform dispatcher
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true; // marks error as handled
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()..add(AppStarted())),
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
        supportedLocales: const [Locale('en')],
      ),
    );
  }
}
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
//
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.popAndPushNamed(context, Login.route);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child:Image.asset('assets/images/splash_screen_dev.png',height: 200,width: 200,)));
//   }
// }


