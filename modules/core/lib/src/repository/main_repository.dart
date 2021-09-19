import 'package:flutter/material.dart';

import 'package:core/core.dart';

class MainRepository implements Repository {
  final ApiRepository apiRepository;
  final LocalRepository localRepository;

  MainRepository(
      {@required this.apiRepository, @required this.localRepository});


  /// Market
  @override
  Future<ChartResult> getMarketChart(
      String range,
      String primaryCurrency,
      String secondaryCurrency) async {

    try {
      var fromLocal = await localRepository.getMarketChart(range, primaryCurrency, secondaryCurrency);

      if (fromLocal != null) {
        return fromLocal;
      } else {
        throw Exception();
      }

    } catch (_) {
      var fromDio = await apiRepository.getMarketChart(range, primaryCurrency, secondaryCurrency);
      localRepository.saveMarketChart(fromDio, range);

      return fromDio;
    }

  }



}
