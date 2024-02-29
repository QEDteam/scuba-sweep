// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreInfo _$ScoreInfoFromJson(Map<String, dynamic> json) => ScoreInfo(
      nickname: json['nickname'] as String?,
      score: json['score'] as int? ?? 0,
    );

Map<String, dynamic> _$ScoreInfoToJson(ScoreInfo instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'score': instance.score,
    };
