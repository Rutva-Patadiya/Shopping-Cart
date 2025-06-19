import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

extension FirebaseHandler<T> on Future<T> {
  Future<T?> handleFirebase({String? logName, bool showDebug = true}) async {
    try {
      return await this;
    } on FirebaseException catch (e) {
      // multiple exceptions hanlding required
      if (showDebug && kDebugMode) {
        log(
          "[FIREBASE ERROR] ${logName ?? ''} => Code: ${e.code}, Message: ${e.message}",
        );
      }
    } catch (e) {
      if (showDebug && kDebugMode) {
        log("[UNEXPECTED ERROR ] ${logName ?? ''} => $e");
      }
    }
    return null;
  }
}
