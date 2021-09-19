import 'package:equatable/equatable.dart';

abstract class ChartEvent extends Equatable {

  final String range;
  final String primaryCurrency;
  final String secondaryCurrency;

  const ChartEvent(this.range, this.primaryCurrency, this.secondaryCurrency);

  @override
  List<Object> get props => [range, primaryCurrency, secondaryCurrency];
}

class GetChart extends ChartEvent {
  GetChart(String range, String primaryCurrency, String secondaryCurrency) :
        super(range, primaryCurrency, secondaryCurrency);
}

class ChartStateChange extends ChartEvent {
  ChartStateChange([String range, String primaryCurrency, String secondaryCurrency]) : super(range, primaryCurrency, secondaryCurrency);
}
