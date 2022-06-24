import 'package:flutter/foundation.dart';
import 'dart:developer' as logger;

void console(String tag, Object? message) {
  if (kDebugMode) {
    logger.log(tag, error: message);
  }
}
