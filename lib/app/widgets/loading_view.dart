import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto_price_tracker/app/values/app_colors.dart';
import 'package:crypto_price_tracker/app/themes/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

  class LoadingView extends StatelessWidget {
  final Color? color;
  final String? message;

  const LoadingView({this.color, this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: color ?? AppColors.black.withValues(alpha: 0.3),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetPlatform.isAndroid
                ? const CircularProgressIndicator()
                : CupertinoActivityIndicator(
                    color: AppColors.white,
                    radius: 15.r,
                  ),
            if (message != null) ...[
              SizedBox(
                height: 8.h,
              ),
              Material(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: Text(
                    message!,
                    style: AppStyles.textStyle(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
