import 'dart:convert';

import 'package:flutter_base_architecture/utils/log.dart';
import 'package:http/http.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Response> request(
      {required RequestType requestType,
      required String endPoint,
      Object? body,
      Map<String, String>? headers}) async {
    switch (requestType) {
      case RequestType.get:
        return getRequest(endPoint, headers);
      case RequestType.post:
        return postRequest(endPoint, body, headers);
      case RequestType.delete:
        deleteRequest(endPoint, body, headers);
        break;
      case RequestType.put:
        putRequest(endPoint, body, headers);
        break;
      case RequestType.patch:
        patchRequest(endPoint, body, headers);
        break;
      default:
        log(kTag, "No RequestType Provided.");
    }

    return Response("Failure", 0);
  }

  /// *
  /// GET REQUEST
  /// */
  Future<Response> getRequest(String endPoint,
      [Map<String, String>? headers]) async {
    try {
      var response = await get(Uri.parse(baseUrl + endPoint), headers: headers);
      return response;
    } catch (ex) {
      log(kTag, "--------------- getRequest Exception -------------- ");
      log(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// POST REQUEST
  /// */
  Future<Response> postRequest(String endPoint, Object? body,
      [Map<String, String>? headers]) async {
    try {
      var response = await post(Uri.parse(baseUrl + endPoint),
          body: body, headers: headers);
      return response;
    } catch (ex) {
      log(kTag, "--------------- postRequest Exception -------------- ");
      log(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// DELETE REQUEST
  /// */
  Future<Response> deleteRequest(String endPoint, Object? body,
      [Map<String, String>? headers]) async {
    try {
      var response = await delete(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      log(kTag, "--------------- deleteRequest Exception -------------- ");
      log(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// PUT REQUEST
  /// */
  Future<Response> putRequest(String endPoint, Object? body,
      [Map<String, String>? headers]) async {
    try {
      var response = await put(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      log(kTag, "--------------- putRequest Exception -------------- ");
      log(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// PATCH REQUEST
  /// */
  Future<Response> patchRequest(String endPoint, Object? body,
      [Map<String, String>? headers]) async {
    try {
      var response = await patch(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      log(kTag, "--------------- patchRequest Exception -------------- ");
      log(kTag, ex);
    }
    return Response("Failure", 0);
  }
}

enum RequestType { get, post, delete, put, patch }

const kTag = "ApiService";
