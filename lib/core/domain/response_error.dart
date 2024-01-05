import 'dart:developer';
import '../client/client_http_exception.dart';

abstract class ResponseError implements Exception {
  final String message;
  final int code;
  final StackTrace? stackTrace;
  final Object? error;

  ResponseError({
    required this.message,
    required this.code,
    this.stackTrace,
    this.error,
  }) {
    log(toString());
  }

  @override
  String toString() {
    return "StackTrace: "
        "${stackTrace ?? formattedStackTrace()} \n "
        "Error: ${error.toString()} \n "
        "Code: $code \n "
        "Message: $message, \n "
        "AnswerError: $runtimeType \n "
        "Hora: ${DateTime.now()} \n ";
  }

  StackTrace? formattedStackTrace() {
    if (error is Error) {
      return (error as Error).stackTrace;
    } else {
      String formattedStackTrace = StackTrace.current.toString();
      final stackList = formattedStackTrace.split(r'#');

      if (stackList.length > 1) {
        stackList.removeWhere(
            (element) => element.toLowerCase().contains('answer_error.dart'));
        formattedStackTrace = stackList.join('');
      }
      return StackTrace.fromString(formattedStackTrace);
    }
  }
}

class ResponseGenericError extends ResponseError {
  final String? errorMessage;
  final int? errorCode;

  final StackTrace? stackError;
  ResponseGenericError({
    this.errorMessage,
    this.errorCode,
    required super.error,
    this.stackError,
  }) : super(
          message:
              errorMessage ?? "Tivemos um erro, tente novamente mais tarde.",
          code: errorCode ?? 0,
          stackTrace: stackError,
        );
}

class ResponseClientError extends ResponseError {
  final String? errorMessage;
  final int? errorCode;
  final StackTrace? stackError;
  final ClientHttpException exception;
  ResponseClientError({
    this.errorMessage,
    this.errorCode,
    this.stackError,
    required this.exception,
  }) : super(
          message: _handlerErrorMessage(errorMessage, exception),
          code: _handlerErrorCode(errorCode, exception),
          stackTrace: stackError,
          error: exception,
        );
}

String _handlerErrorMessage(
    String? errorMessage, ClientHttpException exception) {
  if (errorMessage != null) {
    return errorMessage;
  } else if (exception.responseMessage != null) {
    return exception.responseMessage!;
  } else {
    return "Tivemos um problema técnico, tente novamente mais tarde.";
  }
}

int _handlerErrorCode(int? errorCode, ClientHttpException exception) {
  if (errorCode != null) {
    return errorCode;
  } else if (exception.responseCode != null) {
    return exception.responseCode!;
  } else {
    return 1;
  }
}

class ResponseMinorError extends ResponseError {
  ResponseMinorError({
    required super.message,
    super.code = 2,
    super.stackTrace,
    super.error,
  });
}

class InstabilityError extends ResponseError {
  final ClientHttpException exception;

  InstabilityError({
    super.message =
        'Tivemos um erro de instabilidade, ' 'tente novamente mais tarde.',
    super.code = 3,
    super.stackTrace,
    required this.exception,
  }) : super(
          error: exception,
        );
}
