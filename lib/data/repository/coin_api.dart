import 'dart:convert';
import 'package:crypto_price_tracker/data/models/error_model.dart';
import 'package:crypto_price_tracker/data/models/coin_model.dart';
import 'package:crypto_price_tracker/data/repository/coin_repository.dart';
import 'package:crypto_price_tracker/core/network/api_base.dart';
import 'package:crypto_price_tracker/app/values/app_strings.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CoinRepository)
class CoinRest extends CoinRepository {
  final ApiBase httpClient;
  CoinRest(this.httpClient);

  @override
  Future<({List<CoinModel>? data, ErrorModel? error})> getCoins() async {
    const url = 'https://api.coingecko.com/api/v3/coins/markets'
        '?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false';

    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return (
      error: null,
      data: coinModelFromJson(
        response.data is String ? response.data : jsonEncode(response.data),
      ),
      );
    } else if (response.statusCode == 404) {
      return (error: ErrorModel(error: AppStrings.endpointNotFound), data: null);
    } else {
      return (error: ErrorModel(error: AppStrings.serverError), data: null);
    }
  }
}