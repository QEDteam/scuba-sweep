// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AiMessageState {
  String get message => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AiMessageStateCopyWith<AiMessageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiMessageStateCopyWith<$Res> {
  factory $AiMessageStateCopyWith(
          AiMessageState value, $Res Function(AiMessageState) then) =
      _$AiMessageStateCopyWithImpl<$Res, AiMessageState>;
  @useResult
  $Res call({String message, bool isLoading});
}

/// @nodoc
class _$AiMessageStateCopyWithImpl<$Res, $Val extends AiMessageState>
    implements $AiMessageStateCopyWith<$Res> {
  _$AiMessageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiMessageStateImplCopyWith<$Res>
    implements $AiMessageStateCopyWith<$Res> {
  factory _$$AiMessageStateImplCopyWith(_$AiMessageStateImpl value,
          $Res Function(_$AiMessageStateImpl) then) =
      __$$AiMessageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, bool isLoading});
}

/// @nodoc
class __$$AiMessageStateImplCopyWithImpl<$Res>
    extends _$AiMessageStateCopyWithImpl<$Res, _$AiMessageStateImpl>
    implements _$$AiMessageStateImplCopyWith<$Res> {
  __$$AiMessageStateImplCopyWithImpl(
      _$AiMessageStateImpl _value, $Res Function(_$AiMessageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isLoading = null,
  }) {
    return _then(_$AiMessageStateImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AiMessageStateImpl extends _AiMessageState {
  const _$AiMessageStateImpl({this.message = '', this.isLoading = false})
      : super._();

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'AiMessageState(message: $message, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiMessageStateImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AiMessageStateImplCopyWith<_$AiMessageStateImpl> get copyWith =>
      __$$AiMessageStateImplCopyWithImpl<_$AiMessageStateImpl>(
          this, _$identity);
}

abstract class _AiMessageState extends AiMessageState {
  const factory _AiMessageState({final String message, final bool isLoading}) =
      _$AiMessageStateImpl;
  const _AiMessageState._() : super._();

  @override
  String get message;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$AiMessageStateImplCopyWith<_$AiMessageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
