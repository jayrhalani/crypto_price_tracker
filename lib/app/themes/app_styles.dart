import 'package:flutter/cupertino.dart';
import 'package:crypto_price_tracker/app/values/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static EdgeInsets get defaultPadding => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 16.h,
  );

  static EdgeInsets get compactPadding => EdgeInsets.symmetric(
    horizontal: 10.h,
    vertical: 10.h,
  );

  static TextStyle textStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    double? height,
    String? fontFamily,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? 14).sp,
      fontWeight: fontWeight,
      color: color ?? AppColors.black,
      decoration: decoration,
      height: height,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
    );
  }

  static BoxDecoration boxDecoration({
    Color? borderColor,
    Color? color,
  }) {
    return BoxDecoration(
      border: Border.all(
        color: borderColor ?? AppColors.primary.withValues(alpha: 0.2),
      ),
      color: color ?? AppColors.white,
      borderRadius: BorderRadius.circular(8.r),
    );
  }
}
