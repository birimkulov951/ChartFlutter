// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartResult _$ChartResultFromJson(Map<String, dynamic> json) {
  return ChartResult(
    price: json['price'] as double,
    changePercent: json['changePercent'] as double,
    changeAmount: json['changeAmount'] as double,
    high: json['high'] as double,
    low: json['low'] as double,
    volumePrimary24h: json['volumePrimary24h'] as double,
    volumeSecondary24h: json['volumeSecondary24h'] as double,
    holdingsPrimary: json['holdingsPrimary'] as double,
    holdingsSecondary: json['holdingsSecondary'] as double,
    points: (json['points'] as List)?.map((e) => e as double)?.toList(),
    pointsStartFrom: json['pointsStartFrom'] == null ? null : DateTime.parse(json['pointsStartFrom'] as String),
    errorMessage: json['message'] as String,
    fieldName: json['fieldName'] as String,
    isSuccessful: json['success'] as bool,
  );
}

Map<String, dynamic> _$ChartResultToJson(ChartResult instance) => <String, dynamic>{
  'price': instance.price,
  'changePercent': instance.changePercent,
  'changeAmount': instance.changeAmount,
  'high': instance.high,
  'low': instance.low,
  'volumePrimary24h': instance.volumePrimary24h,
  'volumeSecondary24h': instance.volumeSecondary24h,
  'holdingsPrimary': instance.holdingsPrimary,
  'holdingsSecondary': instance.holdingsSecondary,
  'points': instance.points,
  'pointsStartFrom': instance.pointsStartFrom?.toIso8601String(),
  'message': instance.errorMessage,
  'fieldName': instance.fieldName,
  'success': instance.isSuccessful,
};
