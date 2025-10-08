import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypto_price_tracker/app/values/app_colors.dart';
import 'package:crypto_price_tracker/app/themes/app_styles.dart';

void showBotToast({
  required String message,
  bool success = false,
  bool error = false,
  int? duration,
}) {
  BotToast.showNotification(
    title: (_) => Text(
      message,
      style: AppStyles.textStyle(
        color: AppColors.white,
      ),
    ),
    duration: Duration(seconds: duration ?? 3),
    backgroundColor: error
        ? AppColors.error
        : success
        ? AppColors.success
        : AppColors.lightBlack,
    margin: const EdgeInsets.symmetric(horizontal: 8),
  );
}

void debugPrintLocal(dynamic msg) {
  if (kDebugMode) {
    const int maxLogSize = 1000;
    RegExp regExp = RegExp('.{1,$maxLogSize}');
    regExp.allMatches(msg.toString()).forEach((match) {
      // ignore: avoid_print
      print(match.group(0));
    });
  }
}

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}
