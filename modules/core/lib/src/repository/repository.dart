import 'package:core/core.dart';

abstract class Repository {

  /// Market
  Future<ChartResult> getMarketChart(String range, String primaryCurrency, String secondaryCurrency);


}
