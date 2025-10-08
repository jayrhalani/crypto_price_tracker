import 'dart:convert';

List<CoinModel> coinModelFromJson(String str) =>
    List<CoinModel>.from(json.decode(str).map((x) => CoinModel.fromJson(x)));

String coinModelToJson(List<CoinModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoinModel {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double? marketCap;
  final double? high24h;
  final double? low24h;
  final double? priceChange24h;
  final double? priceChangePercentage24h;
  final double? marketCapChangePercentage24h;

  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    this.marketCap,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCapChangePercentage24h,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
    id: json["id"] ?? '',
    symbol: json["symbol"] ?? '',
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    currentPrice: (json["current_price"] ?? 0).toDouble(),
    marketCap: (json["market_cap"] ?? 0).toDouble(),
    high24h: (json["high_24h"] ?? 0).toDouble(),
    low24h: (json["low_24h"] ?? 0).toDouble(),
    priceChange24h: (json["price_change_24h"] ?? 0).toDouble(),
    priceChangePercentage24h:
    (json["price_change_percentage_24h"] ?? 0).toDouble(),
    marketCapChangePercentage24h:
    (json["market_cap_change_percentage_24h"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "image": image,
    "current_price": currentPrice,
    "market_cap": marketCap,
    "high_24h": high24h,
    "low_24h": low24h,
    "price_change_24h": priceChange24h,
    "price_change_percentage_24h": priceChangePercentage24h,
    "market_cap_change_percentage_24h": marketCapChangePercentage24h,
  };
}