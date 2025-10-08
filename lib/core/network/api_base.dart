import 'package:dio/dio.dart';
import 'package:crypto_price_tracker/core/network/api_interceptor.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiBase {
  late Dio dioO;

  ApiBase() {
    dioO = dioInit();
  }

  Future<Response> get(
      Uri url, {
        Map<String, String>? headers,
      }) {
    final defaultHeaders = {
      'Accept': 'application/json',
    };

    final mergedHeaders = {
      ...defaultHeaders,
      if (headers != null) ...headers,
    };

    return dioO.get(
      url.toString(),
      options: Options(
        headers: mergedHeaders,
      ),
    );
  }


  Future<Response> post(
    Uri url, {
    Object? body,
    Map<String, String>? headers,
  }) {
    Object? formData =
        body is Map<String, dynamic> ? FormData.fromMap(body) : body;

    return dioO.post(
      url.toString(),
      data: formData,
      options: Options(
        headers: headers,
      ),
    );
  }

  Dio dioInit() {
    final dioO = Dio();
    dioO.interceptors.add(ApiInterceptor());
    return dioO;
  }
}
