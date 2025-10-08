import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:crypto_price_tracker/app/widgets/helper_utils.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrintLocal('\n[Request] ------------------------------');

    final method = options.method;
    final url = options.uri.toString();
    final headers = options.headers;
    final data = options.data;
    final requestBody = _extractRequestBody(data);

    debugPrintLocal('$method ---> $url');
    debugPrintLocal('Headers: $headers');
    debugPrintLocal('Body: $requestBody');
    debugPrintLocal('------------------------------------------\n');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrintLocal('\n[Response] -----------------------------');

    final method = response.requestOptions.method;
    final url = response.requestOptions.uri.toString();
    // final requestBody = _extractRequestBody(response.requestOptions.data);
    final responseBody = response.data;

    if (responseBody is String && response.statusCode == 200) {
      final trimmed = responseBody.trim();
      if (trimmed.isEmpty || !_isValidJsonStart(trimmed[0])) {
        response.statusCode = 500; // Invalid JSON format
      }
    }

    debugPrintLocal('$method ---> $url');
    debugPrintLocal('Response Code: ${response.statusCode}');
    debugPrintLocal('Response Body: $responseBody');
    debugPrintLocal('------------------------------------------\n');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrintLocal('\n[Error] --------------------------------');

    final url = err.requestOptions.uri.toString();
    final headers = err.requestOptions.headers;
    final data = err.requestOptions.data;
    final body = _extractRequestBody(data);

    debugPrintLocal('Request URL: $url');
    debugPrintLocal('Headers: $headers');
    debugPrintLocal('Body: $body');
    debugPrintLocal('Error: $err');
    debugPrintLocal('------------------------------------------\n');

    super.onError(err, handler);
  }

  String? _extractRequestBody(dynamic data) {
    if (data == null) return null;

    if (data is FormData) {
      return jsonEncode(Map.fromEntries(data.fields));
    } else if (data is Map) {
      return jsonEncode(data);
    } else {
      return data.toString();
    }
  }

  bool _isValidJsonStart(String char) {
    return char == "{" || char == "[" || char == "\"";
  }
}
