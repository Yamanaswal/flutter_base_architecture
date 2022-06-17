import 'dart:convert';

import 'package:flutter_base_architecture/models/network/api_service/api_services.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_urls.dart';
import 'package:flutter_base_architecture/models/network/models/posts.dart';

import '../../../utils/log.dart';

class ApiUtility {

  ApiService apiService = ApiService(baseUrl: "https://jsonplaceholder.typicode.com");

  void callApiDemo() async {

    var response = await apiService.request(
        requestType: RequestType.get,
        endPoint: ApiEndPoints.posts);

    List<Posts> posts = (json.decode(response.body) as List).map((i) => Posts.fromJson(i)).toList();

    log("Get",posts[0].title);

    var res = await apiService.request(
      requestType: RequestType.post, endPoint: ApiEndPoints.posts,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'title': "laboriosam dolor voluptates",
      }),
    );

    var postTypeData = Posts.fromJson(jsonDecode(res.body));
    log("POST DATA: ", res.body);
    log("POST DATA: ", postTypeData.body);

  }

}
