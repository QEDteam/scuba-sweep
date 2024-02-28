import 'package:json_annotation/json_annotation.dart';

part 'score_info_model.g.dart';

@JsonSerializable()
class ScoreInfo {
  final String? nickname;
  final int score;

  ScoreInfo({
    this.nickname,
    this.score = 0,
});

  factory ScoreInfo.fromJson(Map<String, dynamic> json) =>
      _$ScoreInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreInfoToJson(this);
}
