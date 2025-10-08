import 'package:crypto_price_tracker/data/models/error_model.dart';
import 'package:crypto_price_tracker/data/repository/coin_repository.dart';
import 'package:crypto_price_tracker/injection/injection.dart';
import 'package:crypto_price_tracker/features/bloc/coin/coin_state.dart';
import 'package:crypto_price_tracker/core/network/handle_exception.dart';
import 'package:crypto_price_tracker/app/values/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinCubit extends Cubit<CoinState> {
  CoinCubit() : super(CoinInitial());

  final repository = getIt<CoinRepository>();

  Future<void> getCoins() async {
    try {
      emit(CoinLoading());
      final result = await repository.getCoins();

      if (result.error != null) {
        emit(CoinError(data: result.error!));
      } else if (result.data != null) {
        emit(CoinSuccess(coins: result.data!));
      } else {
        emit(CoinError(data: ErrorModel(error: AppStrings.somethingWentWrong)));
      }
    } catch (e, s) {
      emit(
        CoinError(
          data: ErrorModel(error: HandleException.interpretError(e, s)),
        ),
      );
    }
  }
}
