import 'package:crypto_price_tracker/data/models/error_model.dart';
import 'package:crypto_price_tracker/data/models/coin_model.dart';

abstract class CoinState {}

class CoinInitial extends CoinState {}

class CoinLoading extends CoinState {}

class CoinSuccess extends CoinState {
  final List<CoinModel> coins;
  CoinSuccess({required this.coins});
}

class CoinError extends CoinState {
  final ErrorModel data;
  CoinError({required this.data});
}
