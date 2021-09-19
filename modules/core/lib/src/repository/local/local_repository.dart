import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class LocalRepository implements Repository {

  final SharedPrefHelper prefHelper;

  LocalRepository({@required this.prefHelper});


  /// Market
  @override
  Future<ChartResult> getMarketChart(
      String range,
      String primaryCurrency,
      String secondaryCurrency) async {

    var fromCache;

    if (range == '1d') {
      fromCache = await prefHelper.getCache(AppConstants.MARKET_CHART_1D);
    }
    else if (range == '1w') {
      fromCache = await prefHelper.getCache(AppConstants.MARKET_CHART_1W);
    }
    else if (range == '1M') {
      fromCache = await prefHelper.getCache(AppConstants.MARKET_CHART_1M);
    }
    else if (range == '1y') {
      fromCache = await prefHelper.getCache(AppConstants.MARKET_CHART_1Y);
    }
    else {
      fromCache = await prefHelper.getCache(AppConstants.MARKET_CHART_ALL);
    }

    if (fromCache != null) {
      Map json = jsonDecode(fromCache);

      return ChartResult.fromJson(json);
    }

    return null;
  }

  Future<bool> saveMarketChart(ChartResult result, String range) {

    var isSuccessful;
    if (range == '1d') {
      isSuccessful = prefHelper.storeCache(AppConstants.MARKET_CHART_1D, jsonEncode(result));
    } else if (range == '1w') {
      isSuccessful = prefHelper.storeCache(AppConstants.MARKET_CHART_1W, jsonEncode(result));
    }
    else if (range == '1M') {
      isSuccessful = prefHelper.storeCache(AppConstants.MARKET_CHART_1M, jsonEncode(result));
    }
    else if (range == '1y') {
      isSuccessful = prefHelper.storeCache(AppConstants.MARKET_CHART_1Y, jsonEncode(result));
    }
    else {
      isSuccessful = prefHelper.storeCache(AppConstants.MARKET_CHART_ALL, jsonEncode(result));
    }

    print('SAVE $range');
    return isSuccessful;
  }



}
