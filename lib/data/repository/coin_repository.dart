import 'package:crypto_price_tracker/data/models/error_model.dart';
import 'package:crypto_price_tracker/data/models/coin_model.dart';

abstract class CoinRepository {
  Future<({ErrorModel? error, List<CoinModel>? data})> getCoins();
}
