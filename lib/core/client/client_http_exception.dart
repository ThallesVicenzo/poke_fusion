import 'dart:developer';

import 'package:poke_fusion/core/client/client_http_response.dart';

class ClientHttpException implements Exception {
  String? path;
  String? message;
  int? statusCode;
  dynamic error;
  ClientHttpResponse? response;
  dynamic requestData;
  Map<String, dynamic>? queryParameters;

  ClientHttpException({
    this.path,
    this.message,
    this.statusCode,
    required this.error,
    this.response,
    this.requestData,
    this.queryParameters,
  }) {
    log(toString(), name: "ClientHttpException");
  }

  @override
  String toString() {
    return 'ClientHttpException( '
        'message: $responseMessage, \n'
        'statusCode: $responseCode, \n'
        'error: $error, \n'
        'Path: $path \n'
        'response data: ${response.toString()}) \n';
  }

  int? get responseCode {
    int? responseStatusCode;
    if (response?.data is Map) {
      if (response?.responseStatusCode != null) {
        return response?.responseStatusCode;
      }
      responseStatusCode = response?.data?["errorCode"];
    } else {
      responseStatusCode = response?.statusCode;
    }

    return responseStatusCode ?? statusCode;
  }

  String? get responseMessage {
    String? responseMessage;
    if (response?.data is Map) {
      if (response?.responseStatusMessage != null) {
        return response?.responseStatusMessage;
      }
      responseMessage = response?.data?["errorMessage"];
      responseMessage ??= response?.data?["message"];
    } else {
      responseMessage = response?.statusMessage;
    }

    return responseMessage ?? message;
  }
}
