import 'package:flutter/foundation.dart';
import 'dart:developer' as logger;

void log(String tag, Object? message) {
  if (kDebugMode) {
    logger.log(tag, error: message);
  }
}
