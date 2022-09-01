
import 'package:flutter/foundation.dart';

class ApiEndPoints {
  // Base Url
  static const baseUrl = kDebugMode ? "https://jsonplaceholder.typicode.com" : "https://jsonplaceholder.typicode.com";

  static const posts = "/posts";
  static const post = "/posts?id=1";
}