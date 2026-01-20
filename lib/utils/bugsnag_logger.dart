import 'dart:developer' as developer;
import 'package:bugsnag_flutter/bugsnag_flutter.dart';
import 'package:flutter/foundation.dart';

class BugsnagLogger {
  static void init() {
    // Redirect Flutter debugPrint
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) {
        developer.log(message); // still logs locally
        bugsnag.addFeatureFlag("log", message); // attach to Bugsnag metadata
      }
    };
  }
}
