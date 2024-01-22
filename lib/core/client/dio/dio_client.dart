import 'package:dio/dio.dart';
import 'package:poke_fusion/core/client/client_http.dart';
import 'package:poke_fusion/core/client/client_http_exception.dart';
import 'package:poke_fusion/core/client/client_http_response.dart';

class DioClient implements ClientHttp {
  late Dio _dio;

  Dio get dio => _dio;

  DioClient({
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(baseOptions);
    _dio.interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      ],
    );
  }

  @override
  Future<ClientHttpResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioException catch (e) {
      throw ClientHttpException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  @override
  Future<ClientHttpResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioException catch (e) {
      throw ClientHttpException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
      );
    }
  }

  @override
  Future<ClientHttpResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioException catch (e) {
      throw ClientHttpException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  @override
  Future<ClientHttpResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioException catch (e) {
      throw ClientHttpException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  @override
  Future<ClientHttpResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioException catch (e) {
      throw ClientHttpException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  @override
  Future<ClientHttpResponse<T>> request<T>(String path,
      {data,
      required String method,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );
      return _dioResponseConverter<T>(response);
    } on DioException catch (e) {
      throw ClientHttpException(
        path: path,
        error: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        message: e.response?.statusMessage,
        response: _dioErrorResponseConverter(e.response),
        queryParameters: queryParameters,
        requestData: data,
      );
    }
  }

  ClientHttpResponse? _dioErrorResponseConverter(Response? response) {
    return ClientHttpResponse(
      data: response?.data,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
    );
  }

  ClientHttpResponse<T> _dioResponseConverter<T>(Response response) {
    return ClientHttpResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }
}
