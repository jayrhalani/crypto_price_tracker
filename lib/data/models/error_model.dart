import 'dart:convert';

import 'package:crypto_price_tracker/app/values/app_strings.dart';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

class ErrorModel {
  String? error;
  String? status;
  String? message;

  ErrorModel({
    this.error,
    this.status,
    this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    error: json["error"]?.toString(),
    status: json["status"]?.toString(),
    message: json["message"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "status": status,
    "message": message,
  };

  @override
  String toString() {
    return message ?? error ?? status ?? AppStrings.somethingWentWrong;
  }
}
