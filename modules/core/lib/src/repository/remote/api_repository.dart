import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ApiRepository implements Repository {

  final ApiService apiService;

  ApiRepository({@required this.apiService});


  /// Market
  @override
  Future<ChartResult> getMarketChart(String range, String primaryCurrency, String secondaryCurrency) {
    return apiService.getMarketChart(range, primaryCurrency, secondaryCurrency);
  }



}
