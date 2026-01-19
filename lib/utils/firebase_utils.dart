import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

extension FirebaseHandler<T> on Future<T> {
  Future<T?> handleFirebase({String? logName, bool showDebug = true}) async {
    try {
      return await this;
    } on FirebaseException catch (e) {
      if (showDebug && kDebugMode) {
        log(
          "[FIREBASE ERROR] ${logName ?? ''} => Code: ${e.code}, Message: ${e.message}",
        );
      }
      switch (e.code) {
        case 'permission-denied':
          throw Exception('Permission denied');
        case 'not-found':
          throw Exception('Collection not found');
        case 'unavailable':
          throw Exception('Network is not available');
      }
    } catch (e) {
      if (showDebug && kDebugMode) {
        log("[UNEXPECTED ERROR ] ${logName ?? ''} => $e");
      }
    }
    return null;
  }
}
