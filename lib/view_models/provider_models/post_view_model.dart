
import 'package:flutter/foundation.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_response.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_manager.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_urls.dart';

import '../../models/network/models/posts/post.dart';
import '../../utils/log.dart';


class PostViewModel extends ChangeNotifier{

   Future<Post> callApi() async {
     try{
       ApiResponse responseBody = await ApiManager().getRequestApi(endPoint: ApiEndPoints.posts,headers: ApiManager.defaultHeaders);
       return compute(parseData,responseBody.body);
     }catch(ex){
       log("TAG",ex);
       throw Exception(ex);
     }


  }

  Post parseData(dynamic responseBody) {
    return Post.fromJson(responseBody);
  }

}