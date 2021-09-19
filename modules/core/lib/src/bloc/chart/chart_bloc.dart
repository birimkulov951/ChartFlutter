import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core/core.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final Repository repository;

  ChartBloc({@required this.repository}) : super(InitialChart());

  get initialState => InitialChart();

  @override
  Stream<ChartState> mapEventToState(ChartEvent event) async* {
    if (event is GetChart) {
      yield* _mapGetChartToState(event);
    } else if (event is ChartStateChange) {
      yield InitialChart();
    }
  }

  Stream<ChartState> _mapGetChartToState(ChartEvent event) async* {

    try {

      yield ChartLoading();

      var response = await repository.getMarketChart(
          event.range,
          event.primaryCurrency,
          event.secondaryCurrency);

      if (response.errorMessage != null) {
        yield ChartError(response.errorMessage);
      } else {

        if (response.points != null) {
          yield ChartHasData(response);
        } else {
          yield ChartNoData('ChartNoData');
        }
      }

    } on DioError catch (e) {

      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT ||
          e.type == DioErrorType.DEFAULT) {
        yield ChartNoInternetConnection(e.toString());
      } else {
        yield ChartError(e.toString());
      }

    } catch (e) {

      yield ChartError(e.toString());

    }

  }


}
