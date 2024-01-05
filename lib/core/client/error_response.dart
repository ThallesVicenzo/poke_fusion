import 'dart:convert';

class ErrorResponse {
  int? httpStatusCode;
  int? status;
  String? message;

  ErrorResponse({
    this.httpStatusCode,
    this.status,
    this.message,
  });

  String? get messageWithCode {
    if (httpStatusCode != null && message != null) {
      return '$message - $httpStatusCode';
    }
    return message;
  }

  bool isNull() {
    return httpStatusCode == null && status == null && message == null;
  }

  bool containsMessageError(String messageError) {
    messageError = messageError.trim().toLowerCase();
    return message?.trim().toLowerCase().contains(messageError) ?? false;
  }

  factory ErrorResponse.fromIdentifyError(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        return ErrorResponse();
      }
      Map httpBody = {};

      final bodyText = json['http_body'].toString();
      if (bodyText.isNotEmpty) {
        httpBody = bodyText.isNotEmpty ? jsonDecode(bodyText) : {};
      }
      return ErrorResponse(
        httpStatusCode: json['http_status_code'],
        status: httpBody['status'],
        message: httpBody["message"].toString(),
      );
    } catch (e) {
      return ErrorResponse();
    }
  }

  factory ErrorResponse.fromGenericError(dynamic json) {
    if (json is! Map) {
      return ErrorResponse();
    } else {
      try {
        if (json.isEmpty) {
          return ErrorResponse();
        }
        final keyError =
            json.keys.where((key) => key.toString().startsWith('error_'));
        if (keyError.isNotEmpty) {
          return ErrorResponse.fromIdentifyError(json[keyError.first]);
        } else {
          return ErrorResponse();
        }
      } catch (e) {
        return ErrorResponse();
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'http_status_code': httpStatusCode,
      'status': status,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ErrorResponse(httpStatusCode: $httpStatusCode, \n'
        'status: $status, \n'
        'message: $message) \n';
  }
}
