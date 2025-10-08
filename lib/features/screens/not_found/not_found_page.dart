import 'package:flutter/material.dart';
import 'package:crypto_price_tracker/app/themes/app_styles.dart';
import 'package:crypto_price_tracker/app/values/app_assets.dart'; // Make sure this file has AppAssets
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.errorNotFound,
              height: 200.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 32.h),
            Text(
              'Oops! Page not found',
              style: AppStyles.textStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'The page you are looking for might have been removed, renamed, or is temporarily unavailable.',
              style: AppStyles.textStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
