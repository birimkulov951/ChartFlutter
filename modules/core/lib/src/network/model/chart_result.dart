import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_result.g.dart';

@JsonSerializable()
class ChartResult extends Equatable {

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'changePercent')
  final double changePercent;

  @JsonKey(name: 'changeAmount')
  final double changeAmount;

  @JsonKey(name: 'high')
  final double high;

  @JsonKey(name: 'low')
  final double low;

  @JsonKey(name: 'volumePrimary24h')
  final double volumePrimary24h;

  @JsonKey(name: 'volumeSecondary24h')
  final double volumeSecondary24h;

  @JsonKey(name: 'holdingsPrimary')
  final double holdingsPrimary;

  @JsonKey(name: 'holdingsSecondary')
  final double holdingsSecondary;

  @JsonKey(name: 'points')
  final List<double> points;

  @JsonKey(name: 'pointsStartFrom')
  final DateTime pointsStartFrom;

  @JsonKey(name: 'message')
  final String errorMessage;

  @JsonKey(name: 'fieldName')
  final String fieldName;

  @JsonKey(name: 'success')
  final bool isSuccessful;

  const ChartResult(this.price, this.changePercent, this.changeAmount,
      this.high, this.low, this.volumePrimary24h, this.volumeSecondary24h,
      this.holdingsPrimary, this.holdingsSecondary, this.points,
      this.pointsStartFrom, this.errorMessage, this.fieldName,
      this.isSuccessful);

  @override
  List<Object> get props => [price, changePercent, changeAmount, high, low,
    volumePrimary24h, volumeSecondary24h, holdingsPrimary, holdingsSecondary,
    points, pointsStartFrom, errorMessage, fieldName, isSuccessful];

  factory ChartResult.fromJson(Map<String, dynamic> json)=> _$ChartResultFromJson(json);

  Map<String, dynamic> toJson() => _$ChartResultToJson(this);
}