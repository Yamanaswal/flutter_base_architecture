import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_base_architecture/resources/constants/api_urls.dart';
import 'package:library_store/library_store.dart';

import '../../models/network/models/posts/post.dart';

List<Post> parseListData(responseBody) {
  return List<Post>.from(responseBody.map((model) => Post.fromJson(model)));
}

Post parseData(responseBody) {
  return Post.fromJson(responseBody);
}

class PostViewModel extends ChangeNotifier {
  Future<List<Post>> callApiPosts() async {
    try {
      ApiResponse responseBody = await ApiManager().getRequestApi(
        endPoint: ApiEndPoints.posts,
        headers: ApiManager.defaultHeaders,
      );
      Log.e("tag", responseBody.body);
      return compute(parseListData, responseBody.body);
    } catch (ex) {
      Log.e("TAG", ex);
      throw Exception(ex);
    }
  }

  Future<Post> callApi() async {
    try {
      ApiResponse responseBody = await ApiManager().getRequestApi(
        endPoint: ApiEndPoints.post,
        headers: ApiManager.defaultHeaders,
      );
      Log.e("tag", responseBody.body[0]);
      return compute(parseData, responseBody.body[0]);
    } catch (ex) {
      Log.e("TAG", ex);
      throw Exception(ex);
    }
  }
}
