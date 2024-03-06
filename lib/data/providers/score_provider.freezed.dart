// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScoreState {
  int get score => throw _privateConstructorUsedError;
  int get highScore => throw _privateConstructorUsedError;
  List<ScoreInfo> get topHighScores => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScoreStateCopyWith<ScoreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreStateCopyWith<$Res> {
  factory $ScoreStateCopyWith(
          ScoreState value, $Res Function(ScoreState) then) =
      _$ScoreStateCopyWithImpl<$Res, ScoreState>;
  @useResult
  $Res call(
      {int score,
      int highScore,
      List<ScoreInfo> topHighScores,
      bool isLoading,
      String nickname});
}

/// @nodoc
class _$ScoreStateCopyWithImpl<$Res, $Val extends ScoreState>
    implements $ScoreStateCopyWith<$Res> {
  _$ScoreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? highScore = null,
    Object? topHighScores = null,
    Object? isLoading = null,
    Object? nickname = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      highScore: null == highScore
          ? _value.highScore
          : highScore // ignore: cast_nullable_to_non_nullable
              as int,
      topHighScores: null == topHighScores
          ? _value.topHighScores
          : topHighScores // ignore: cast_nullable_to_non_nullable
              as List<ScoreInfo>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScoreStateImplCopyWith<$Res>
    implements $ScoreStateCopyWith<$Res> {
  factory _$$ScoreStateImplCopyWith(
          _$ScoreStateImpl value, $Res Function(_$ScoreStateImpl) then) =
      __$$ScoreStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int score,
      int highScore,
      List<ScoreInfo> topHighScores,
      bool isLoading,
      String nickname});
}

/// @nodoc
class __$$ScoreStateImplCopyWithImpl<$Res>
    extends _$ScoreStateCopyWithImpl<$Res, _$ScoreStateImpl>
    implements _$$ScoreStateImplCopyWith<$Res> {
  __$$ScoreStateImplCopyWithImpl(
      _$ScoreStateImpl _value, $Res Function(_$ScoreStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? highScore = null,
    Object? topHighScores = null,
    Object? isLoading = null,
    Object? nickname = null,
  }) {
    return _then(_$ScoreStateImpl(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      highScore: null == highScore
          ? _value.highScore
          : highScore // ignore: cast_nullable_to_non_nullable
              as int,
      topHighScores: null == topHighScores
          ? _value._topHighScores
          : topHighScores // ignore: cast_nullable_to_non_nullable
              as List<ScoreInfo>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ScoreStateImpl extends _ScoreState {
  const _$ScoreStateImpl(
      {this.score = 0,
      this.highScore = 0,
      final List<ScoreInfo> topHighScores = const [],
      this.isLoading = false,
      this.nickname = ''})
      : _topHighScores = topHighScores,
        super._();

  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int highScore;
  final List<ScoreInfo> _topHighScores;
  @override
  @JsonKey()
  List<ScoreInfo> get topHighScores {
    if (_topHighScores is EqualUnmodifiableListView) return _topHighScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topHighScores);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String nickname;

  @override
  String toString() {
    return 'ScoreState(score: $score, highScore: $highScore, topHighScores: $topHighScores, isLoading: $isLoading, nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreStateImpl &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.highScore, highScore) ||
                other.highScore == highScore) &&
            const DeepCollectionEquality()
                .equals(other._topHighScores, _topHighScores) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @override
  int get hashCode => Object.hash(runtimeType, score, highScore,
      const DeepCollectionEquality().hash(_topHighScores), isLoading, nickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreStateImplCopyWith<_$ScoreStateImpl> get copyWith =>
      __$$ScoreStateImplCopyWithImpl<_$ScoreStateImpl>(this, _$identity);
}

abstract class _ScoreState extends ScoreState {
  const factory _ScoreState(
      {final int score,
      final int highScore,
      final List<ScoreInfo> topHighScores,
      final bool isLoading,
      final String nickname}) = _$ScoreStateImpl;
  const _ScoreState._() : super._();

  @override
  int get score;
  @override
  int get highScore;
  @override
  List<ScoreInfo> get topHighScores;
  @override
  bool get isLoading;
  @override
  String get nickname;
  @override
  @JsonKey(ignore: true)
  _$$ScoreStateImplCopyWith<_$ScoreStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
