import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_response.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_manager.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_urls.dart';

import '../../models/network/models/posts/post.dart';
import '../../utils/log.dart';

List<Post> parseListData(dynamic responseBody) {
  return (json.decode(responseBody) as List).map((i) => Post.fromJson(i)).toList();
}

class PostViewModel extends ChangeNotifier{

  Future<List<Post>> callApi() async {
    try{
      ApiResponse responseBody = await ApiManager().getRequestApi(endPoint: ApiEndPoints.posts,headers: ApiManager.defaultHeaders);
      console("tag", responseBody.body);
      return compute(parseListData,responseBody.body);
    }catch(ex){
      console("TAG",ex);
      throw Exception(ex);
    }
  }

}