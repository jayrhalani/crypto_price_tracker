import 'dart:io';
import 'dart:ui';

import 'package:crypto_price_tracker/app/themes/app_themes.dart';
import 'package:crypto_price_tracker/app/themes/theme_service.dart';
import 'package:crypto_price_tracker/features/bloc/coin/coin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto_price_tracker/injection/injection.dart';
import 'package:crypto_price_tracker/features/screens/dashboard/dashboard_page.dart';
import 'package:crypto_price_tracker/features/screens/not_found/not_found_page.dart';
import 'package:crypto_price_tracker/app/values/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

AppTheme appTheme = AppTheme.system;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = _MyHttpOverrides();

  configureDependencies();
  await loadPreference();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

Future<void> loadPreference() async {
  final themeService = ThemeService();
  appTheme = await themeService.loadTheme();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeMode getThemeMode() {
    return AppThemeManager.getThemeMode(appTheme);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, _) => GetMaterialApp(
        title: 'Crypto Price Tracker',
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        scrollBehavior: _MyCustomScrollBehavior(),
        theme: AppThemeManager.lightTheme,
        darkTheme: AppThemeManager.darkTheme,
        themeMode: getThemeMode(),
        initialRoute: AppRoutes.dashboardScreen,
        unknownRoute: GetPage(
          name: AppRoutes.notFoundScreen,
          page: () => const NotFoundPage(),
        ),
        getPages: [
          GetPage(
            name: AppRoutes.dashboardScreen,
            page: () => BlocProvider(
              create: (_) => CoinCubit(),
              child: const DashboardPage(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
