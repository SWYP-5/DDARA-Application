// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_cycles_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryCyclesResponse _$HistoryCyclesResponseFromJson(
  Map<String, dynamic> json,
) => _HistoryCyclesResponse(
  cycles: (json['cycles'] as List<dynamic>)
      .map((e) => HistoryCycleResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HistoryCyclesResponseToJson(
  _HistoryCyclesResponse instance,
) => <String, dynamic>{'cycles': instance.cycles};

_HistoryCycleResponse _$HistoryCycleResponseFromJson(
  Map<String, dynamic> json,
) => _HistoryCycleResponse(
  cycleId: (json['cycleId'] as num).toInt(),
  cycleNumber: (json['cycleNumber'] as num).toInt(),
  topic: json['topic'] as String,
  starterNickname: json['starterNickname'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  participantCount: (json['participantCount'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$HistoryCycleResponseToJson(
  _HistoryCycleResponse instance,
) => <String, dynamic>{
  'cycleId': instance.cycleId,
  'cycleNumber': instance.cycleNumber,
  'topic': instance.topic,
  'starterNickname': instance.starterNickname,
  'thumbnailUrl': instance.thumbnailUrl,
  'participantCount': instance.participantCount,
  'date': instance.date.toIso8601String(),
};
