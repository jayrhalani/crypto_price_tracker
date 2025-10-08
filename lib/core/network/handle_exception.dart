import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:crypto_price_tracker/app/values/app_strings.dart';
import 'package:crypto_price_tracker/app/widgets/helper_utils.dart';

class HandleException {
  static String interpretError(dynamic exception, StackTrace? stackTrace) {
    logCrash(exception, stackTrace);

    if (exception is SocketException) {
      return AppStrings.noInternetFound;
    } else if (exception is PlatformException) {
      return exception.message ?? exception.code;
    } else if (exception is TimeoutException) {
      return AppStrings.internetError;
    } else if (exception is HttpException) {
      return exception.message;
    } else if (exception is DioException) {
      if (exception.type == DioExceptionType.connectionTimeout ||
          exception.type == DioExceptionType.connectionError) {
        return AppStrings.noInternetFound;
      } else if (exception.type == DioExceptionType.badResponse &&
          exception.message?.contains('404') == true) {
        return AppStrings.endpointNotFound;
      }
      return exception.message ??
          exception.error?.toString() ??
          AppStrings.internetError;
    } else {
      return AppStrings.internetError;
    }
  }

  static void handle(dynamic exception, StackTrace? stackTrace) {
    showBotToast(message: interpretError(exception, stackTrace));
  }

  static void logCrash(dynamic error, StackTrace? trace) {
    debugPrintLocal(error.runtimeType);
    debugPrintLocal(error);
    debugPrintLocal(trace);
  }
}
