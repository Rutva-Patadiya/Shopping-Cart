import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_cart/login/login_page.dart';
import 'package:shopping_cart/utils/router_utils.dart';

import 'core/utils/theme/theme.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'login/bloc/auth_bloc.dart';
import 'login/bloc/auth_event.dart';

Future<void> main() async {
  //ensure flutter sets up
  WidgetsFlutterBinding.ensureInitialized();
  //initialize the firebase sdk (storage,authentication and all)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //set up the crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  //
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  runApp(const MyApp());
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
