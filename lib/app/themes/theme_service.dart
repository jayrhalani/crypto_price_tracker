import 'package:crypto_price_tracker/app/themes/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _key = 'app_theme';

  Future<void> saveTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, theme.index);
  }

  Future<AppTheme> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key) ?? 0;
    return AppTheme.values[index];
  }
}
