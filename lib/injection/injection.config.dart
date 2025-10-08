// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:crypto_price_tracker/core/network/api_base.dart' as _i672;
import 'package:crypto_price_tracker/data/repository/coin_api.dart' as _i739;
import 'package:crypto_price_tracker/data/repository/coin_repository.dart'
    as _i946;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i672.ApiBase>(() => _i672.ApiBase());
    gh.factory<_i946.CoinRepository>(() => _i739.CoinRest(gh<_i672.ApiBase>()));
    return this;
  }
}
