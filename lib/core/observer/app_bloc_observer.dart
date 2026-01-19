import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) developer.log('onCreate — ${bloc.runtimeType}', name: 'BLoC');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) developer.log('onEvent — ${bloc.runtimeType}: $event', name: 'BLoC');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) developer.log('onChange — ${bloc.runtimeType}: $change', name: 'BLoC');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) developer.log('onTransition — ${bloc.runtimeType}: $transition', name: 'BLoC');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log(
      'onError — ${bloc.runtimeType}: $error',
      name: 'BLoC',
      error: error,
      stackTrace: stackTrace,
    );
    // Also report to Crashlytics
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: false);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) developer.log('onClose — ${bloc.runtimeType}', name: 'BLoC');
    super.onClose(bloc);
  }
}