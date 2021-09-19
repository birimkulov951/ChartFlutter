import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {

  final Dio dio;
  ApiService({@required this.dio});

  /// Market
  /// market/chart
  Future<ChartResult> getMarketChart(
      String range,
      String primaryCurrency,
      String secondaryCurrency) async {

    try {
      final response = await dio.get("/apim/market/chart",
          queryParameters: {"model.range": range, "model.primary": primaryCurrency, "model.secondary": secondaryCurrency},
          options: Options(headers: {'x-mobile-version':'0.1'})
      );

      return ChartResult.fromJson(response.data);

    } on DioError catch (e) {

      return ChartResult.fromJson(e.response.data);
    }

  }





}
