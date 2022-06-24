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
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, String>? fields,
      List<MultipartFile>? files}) async {
    switch (requestType) {
      case RequestType.get:
        return getRequest(endPoint, queryParameters, headers);
      case RequestType.post:
        return postRequest(endPoint, body, headers);
      case RequestType.delete:
        return deleteRequest(endPoint, body, headers);
      case RequestType.put:
        return putRequest(endPoint, body, headers);
      case RequestType.patch:
        return patchRequest(endPoint, body, headers);
      case RequestType.multipart:
        return multipartRequest(endPoint, fields, files, headers);
      default:
        console(kTag, "No RequestType Provided.");
    }

    return Response("Failure", 0);
  }

  /// *
  /// GET REQUEST
  /// */
  Future<Response> getRequest(
      String endPoint, Map<String, dynamic>? queryParameters,Map<String, String>? headers) async {
    try {
      final uri = Uri.parse(baseUrl + endPoint);
      if (queryParameters != null) {
        uri.replace(queryParameters: queryParameters);
      }
      var response = await get(Uri.parse(baseUrl + endPoint), headers: headers);
      return response;
    } catch (ex) {
      console(kTag, "--------------- getRequest Exception -------------- ");
      console(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// POST REQUEST
  /// */
  Future<Response> postRequest(String endPoint, Object? body,Map<String, String>? headers) async {
    try {
      var response = await post(Uri.parse(baseUrl + endPoint),
          body: body, headers: headers);
      return response;
    } catch (ex) {
      console(kTag, "--------------- postRequest Exception -------------- ");
      console(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// DELETE REQUEST
  /// */
  Future<Response> deleteRequest(String endPoint, Object? body,Map<String, String>? headers) async {
    try {
      var response = await delete(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      console(kTag, "--------------- deleteRequest Exception -------------- ");
      console(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// PUT REQUEST
  /// */
  Future<Response> putRequest(String endPoint, Object? body,Map<String, String>? headers) async {
    try {
      var response = await put(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      console(kTag, "--------------- putRequest Exception -------------- ");
      console(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// PATCH REQUEST
  /// */
  Future<Response> patchRequest(String endPoint, Object? body, Map<String, String>? headers) async {
    try {
      var response = await patch(Uri.parse(baseUrl + endPoint),
          headers: headers, body: body);
      return response;
    } catch (ex) {
      console(kTag, "--------------- patchRequest Exception -------------- ");
      console(kTag, ex);
    }
    return Response("Failure", 0);
  }

  /// *
  /// MULTIPART REQUEST
  /// */
  Future<Response> multipartRequest(
      String endPoint, Map<String, String>? fields, List<MultipartFile>? files, Map<String, String>? headers) async {
    try {
      MultipartRequest request = MultipartRequest('POST', Uri.parse(baseUrl + endPoint));
      request.headers.addAll(headers ?? {});
      request.fields.addAll(fields ?? {});
      request.files.addAll(files ?? {});

      StreamedResponse response = await request.send();
      return Response.fromStream(response);
    } catch (ex) {
      console(kTag, "--------------- multipartRequest Exception -------------- ");
      console(kTag, ex);
    }
    return Response("Failure", 0);
  }
}

enum RequestType { get, post, delete, put, patch, multipart }

const kTag = "ApiService";
