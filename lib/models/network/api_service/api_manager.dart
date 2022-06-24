import 'dart:convert';

import 'package:flutter_base_architecture/models/network/api_service/api_response.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_services.dart';
import 'package:flutter_base_architecture/models/network/api_service/api_urls.dart';
import 'package:http/http.dart';

import '../../../utils/log.dart';

class ApiManager {
  ApiService apiService = ApiService(baseUrl: "https://jsonplaceholder.typicode.com");

  static const defaultHeaders = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<ApiResponse> getRequestApi(
      {required String endPoint,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await apiService.request(
          requestType: RequestType.get,
          headers: headers ?? defaultHeaders,
          endPoint: ApiEndPoints.posts,
          queryParameters: queryParameters);

      console("$tag Request :->  ", response.request);
      console("$tag Response : Status Code :->  ", response.statusCode);
      console("$tag Response : Headers:->  ", response.headers);
      console("$tag Response : Body ->  ", response.body);

      return ApiResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: json.decode(response.body),
      );
    } catch (ex) {
      console(tag, "----------- getRequestApi Exception -------- ");
      console(tag, ex);
    }
    return ApiResponse(statusCode: 0, headers: {});
  }

  Future<ApiResponse> postRequestApi(
      {required String endPoint,
      Map<String, String>? headers,
      Object? body}) async {
    try {
      var response = await apiService.request(
        requestType: RequestType.post,
        endPoint: endPoint,
        headers: headers ?? defaultHeaders,
        body: jsonEncode(body),
      );

      console("$tag Request :->  ", response.request);
      console("$tag Response : Status Code :->  ", response.statusCode);
      console("$tag Response : Headers:->  ", response.headers);
      console("$tag Response : Body ->  ", response.body);

      return ApiResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: json.decode(response.body),
      );
    } catch (ex) {
      console(tag, "----------- postRequestApi Exception -------- ");
      console(tag, ex);
    }

    return ApiResponse(statusCode: 0, headers: {});
  }

  Future<ApiResponse> multipartRequestApi(
      {required String endPoint,
      Map<String, String>? headers,
      Map<String, String>? fields,
      List<MultipartFile>? files}) async {
    try {
      var response = await apiService.request(
          requestType: RequestType.multipart,
          endPoint: endPoint,
          headers: headers ?? defaultHeaders,
          fields: fields,
          files: files);

      console("$tag Request :->  ", response.request);
      console("$tag Response : Status Code :->  ", response.statusCode);
      console("$tag Response : Headers:->  ", response.headers);
      console("$tag Response : Body ->  ", response.body);

      return ApiResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: json.decode(response.body),
      );
    } catch (ex) {
      console(tag, "----------- postRequestApi Exception -------- ");
      console(tag, ex);
    }

    return ApiResponse(statusCode: 0, headers: {});
  }
}

const tag = "ApiManager";
