import 'dart:convert';
import 'dart:io';

import 'package:edupower_dashboard/shared/function/dev_print.dart';
import 'package:http/http.dart' as http;

enum RequestStatus {
  successRequest,
  failedRequest,
  failedParsing,
  serverError,
  internetIssue,
  cancelRequest
}

class ApiReturnValue<T> {
  T data;
  RequestStatus status;

  ApiReturnValue({required this.data, required this.status});

  static Future<ApiReturnValue<dynamic>> httpGETRequest({
    required String url,
    List<int>? exceptionStatusCode,
  }) async {
    ApiReturnValue<dynamic> returnValue;

    devPrint("GET Request To:");
    devPrint(url);
    devPrint('----------------------------------------------------');

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      var data = json.decode(response.body);
      devPrint("Status Code:");
      devPrint(response.statusCode);
      devPrint("Response:");
      devPrint(data);

      if (response.statusCode != 200) {
        if (exceptionStatusCode != null) {
          if (exceptionStatusCode.contains(response.statusCode)) {
            returnValue = ApiReturnValue(
                status: RequestStatus.successRequest, data: data);
          } else {
            returnValue =
                ApiReturnValue(data: data, status: RequestStatus.failedRequest);
          }
        } else {
          returnValue =
              ApiReturnValue(data: data, status: RequestStatus.failedRequest);
        }
      } else {
        returnValue =
            ApiReturnValue(status: RequestStatus.successRequest, data: data);
      }
    } on SocketException {
      returnValue =
          ApiReturnValue(data: null, status: RequestStatus.internetIssue);
    } catch (e) {
      returnValue =
          ApiReturnValue(status: RequestStatus.serverError, data: null);
    }

    return returnValue;
  }

  static Future<ApiReturnValue<dynamic>> httpPostRequest({
    required String url,
    required Map<String, dynamic> body,
    List<int>? exceptionStatusCode,
  }) async {
    ApiReturnValue<dynamic> returnValue;

    devPrint("POST Request To:");
    devPrint(url);
    devPrint('----------------------------------------------------');

    try {
      final response = await http.post(Uri.parse(url), body: body);
      var data = json.decode(response.body);
      devPrint("Status Code:");
      devPrint(response.statusCode);
      devPrint("Response:");
      devPrint(data);

      if (response.statusCode != 200) {
        if (exceptionStatusCode != null) {
          if (exceptionStatusCode.contains(response.statusCode)) {
            returnValue = ApiReturnValue(
                status: RequestStatus.successRequest, data: data);
          } else {
            returnValue =
                ApiReturnValue(data: data, status: RequestStatus.failedRequest);
          }
        } else {
          returnValue =
              ApiReturnValue(data: data, status: RequestStatus.failedRequest);
        }
      } else {
        returnValue =
            ApiReturnValue(status: RequestStatus.successRequest, data: data);
      }
    } on SocketException {
      returnValue =
          ApiReturnValue(data: null, status: RequestStatus.internetIssue);
    } catch (e) {
      returnValue =
          ApiReturnValue(status: RequestStatus.serverError, data: null);
    }

    return returnValue;
  }
}
