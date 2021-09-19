// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartResult _$ChartResultFromJson(Map<String, dynamic> json) {
  return ChartResult(
    json['price'] as double,
    json['changePercent'] as double,
    json['changeAmount'] as double,
    json['high'] as double,
    json['low'] as double,
    json['volumePrimary24h'] as double,
    json['volumeSecondary24h'] as double,
    json['holdingsPrimary'] as double,
    json['holdingsSecondary'] as double,
    (json['points'] as List)?.map((e) => e as double)?.toList(),
    json['pointsStartFrom'] == null ? null : DateTime.parse(json['pointsStartFrom'] as String),
    json['message'] as String,
    json['fieldName'] as String,
    json['success'] as bool,
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
