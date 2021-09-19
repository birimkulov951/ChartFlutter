import 'package:equatable/equatable.dart';

import 'package:core/core.dart';

abstract class ChartState extends Equatable {
  const ChartState();

  @override
  List<Object> get props => [];
}

class InitialChart extends ChartState {}

class ChartLoading extends ChartState {}

class ChartHasData extends ChartState {

  final ChartResult result;

  const ChartHasData(this.result);

  @override
  List<Object> get props => [result];
}

class ChartNoData extends ChartState {

  final String message;

  const ChartNoData(this.message);

  @override
  List<Object> get props => [message];
}

class ChartNoInternetConnection extends ChartState {
  final String message;

  const ChartNoInternetConnection(this.message);

  @override
  List<Object> get props => [message];
}

class ChartError extends ChartState {
  final String errorMessage;

  const ChartError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
