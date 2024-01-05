import 'package:poke_fusion/core/client/error_response.dart';

class ClientHttpResponse<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;
  ErrorResponse _errorResponse = ErrorResponse();

  ClientHttpResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
  }) {
    if (data is Map) {
      _errorResponse = ErrorResponse.fromGenericError(data);
    }
  }

  @override
  String toString() {
    return 'ClientHttpResponse(statusCode: $statusCode, \n'
        'statusMessage: $statusMessage, \n'
        'data: ${data.toString()}) \n'
        'errorResponse: ${_errorResponse.toString()} \n';
  }

  bool get isStatusCodeSuccess {
    if (statusCode == null) {
      return false;
    } else {
      return statusCode! >= 200 && statusCode! < 300;
    }
  }

  int? get responseStatusCode =>
      _errorResponse.httpStatusCode ?? statusCode ?? _errorResponse.status;

  String? get responseStatusMessage => _errorResponse.message ?? statusMessage;
}
