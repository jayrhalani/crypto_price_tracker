import 'package:crypto_price_tracker/app/themes/app_themes.dart';
import 'package:crypto_price_tracker/app/themes/theme_service.dart';
import 'package:crypto_price_tracker/app/values/app_strings.dart';
import 'package:crypto_price_tracker/app/widgets/helper_utils.dart';
import 'package:crypto_price_tracker/app/widgets/loading_view.dart';
import 'package:crypto_price_tracker/core/controller/dashboard_controller.dart';
import 'package:crypto_price_tracker/features/bloc/coin/coin_cubit.dart';
import 'package:crypto_price_tracker/features/bloc/coin/coin_state.dart';
import 'package:crypto_price_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardController _controller = Get.put(DashboardController());
  final ThemeService _themeService = ThemeService();

  @override
  void initState() {
    super.initState();
    _fetchCoins();
  }

  Future<void> _toggleTheme() async {
    final isDark = Get.isDarkMode;
    final newTheme = isDark ? AppTheme.light : AppTheme.dark;

    // Save the theme persistently
    await _themeService.saveTheme(newTheme);

    // Apply the theme dynamically
    appTheme = newTheme;
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);

    // Rebuild to update icon
    setState(() {});
  }

  IconData get themeIcon => Get.isDarkMode ? Icons.light_mode : Icons.dark_mode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoinCubit, CoinState>(
      listener: (context, state) {
        if (state is CoinSuccess) {
          _controller.coinList.assignAll(state.coins);
        } else if (state is CoinError) {
          showBotToast(
            message: state.data.error ?? AppStrings.somethingWentWrong,
            error: true,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text("Crypto Tracker"),
                titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                actions: [
                  IconButton(icon: Icon(themeIcon), onPressed: _toggleTheme),
                  const SizedBox(width: 8),
                ],
              ),
              body: Obx(() {
                if (_controller.coinList.isEmpty) {
                  return const Center(child: Text('No coins found.'));
                }

                return RefreshIndicator(
                  onRefresh: _fetchCoins,
                  child: ListView.builder(
                    itemCount: _controller.coinList.length,
                    itemBuilder: (context, index) {
                      final coin = _controller.coinList[index];
                      final changeColor =
                          (coin.priceChangePercentage24h ?? 0) >= 0
                          ? Colors.green
                          : Colors.red;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Image.network(
                              coin.image,
                              width: 32,
                              height: 32,
                            ),
                            title: Text(
                              coin.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            subtitle: Text(
                              coin.symbol.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${NumberFormat('#,##,##0.00', 'en_IN').format(coin.currentPrice)}',
                                ),
                                Text(
                                  '${coin.priceChangePercentage24h?.toStringAsFixed(2) ?? '0.00'}%',
                                  style: TextStyle(
                                    color: changeColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
            if (state is CoinLoading) const LoadingView(),
          ],
        );
      },
    );
  }

  Future<void> _fetchCoins() async {
    if (await hasNetwork() && mounted) {
      BlocProvider.of<CoinCubit>(context).getCoins();
    } else {
      showBotToast(message: AppStrings.noInternetFound, error: true);
    }
  }
}
