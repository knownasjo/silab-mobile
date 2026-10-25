// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meetings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeetingsEntity _$MeetingsEntityFromJson(Map<String, dynamic> json) {
  return _MeetingsEntity.fromJson(json);
}

/// @nodoc
mixin _$MeetingsEntity {
  String? get id => throw _privateConstructorUsedError;
  String? get meetingName => throw _privateConstructorUsedError;
  String? get submittedAt => throw _privateConstructorUsedError;
  bool? get isAttended => throw _privateConstructorUsedError;
  bool? get isOpen => throw _privateConstructorUsedError;

  /// Serializes this MeetingsEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeetingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeetingsEntityCopyWith<MeetingsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingsEntityCopyWith<$Res> {
  factory $MeetingsEntityCopyWith(
          MeetingsEntity value, $Res Function(MeetingsEntity) then) =
      _$MeetingsEntityCopyWithImpl<$Res, MeetingsEntity>;
  @useResult
  $Res call(
      {String? id,
      String? meetingName,
      String? submittedAt,
      bool? isAttended,
      bool? isOpen});
}

/// @nodoc
class _$MeetingsEntityCopyWithImpl<$Res, $Val extends MeetingsEntity>
    implements $MeetingsEntityCopyWith<$Res> {
  _$MeetingsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeetingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? meetingName = freezed,
    Object? submittedAt = freezed,
    Object? isAttended = freezed,
    Object? isOpen = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      meetingName: freezed == meetingName
          ? _value.meetingName
          : meetingName // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isAttended: freezed == isAttended
          ? _value.isAttended
          : isAttended // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeetingsEntityImplCopyWith<$Res>
    implements $MeetingsEntityCopyWith<$Res> {
  factory _$$MeetingsEntityImplCopyWith(_$MeetingsEntityImpl value,
          $Res Function(_$MeetingsEntityImpl) then) =
      __$$MeetingsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? meetingName,
      String? submittedAt,
      bool? isAttended,
      bool? isOpen});
}

/// @nodoc
class __$$MeetingsEntityImplCopyWithImpl<$Res>
    extends _$MeetingsEntityCopyWithImpl<$Res, _$MeetingsEntityImpl>
    implements _$$MeetingsEntityImplCopyWith<$Res> {
  __$$MeetingsEntityImplCopyWithImpl(
      _$MeetingsEntityImpl _value, $Res Function(_$MeetingsEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeetingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? meetingName = freezed,
    Object? submittedAt = freezed,
    Object? isAttended = freezed,
    Object? isOpen = freezed,
  }) {
    return _then(_$MeetingsEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      meetingName: freezed == meetingName
          ? _value.meetingName
          : meetingName // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isAttended: freezed == isAttended
          ? _value.isAttended
          : isAttended // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetingsEntityImpl extends _MeetingsEntity {
  const _$MeetingsEntityImpl(
      {this.id,
      this.meetingName,
      this.submittedAt,
      this.isAttended,
      this.isOpen})
      : super._();

  factory _$MeetingsEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetingsEntityImplFromJson(json);

  @override
  final String? id;
  @override
  final String? meetingName;
  @override
  final String? submittedAt;
  @override
  final bool? isAttended;
  @override
  final bool? isOpen;

  @override
  String toString() {
    return 'MeetingsEntity(id: $id, meetingName: $meetingName, submittedAt: $submittedAt, isAttended: $isAttended, isOpen: $isOpen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingsEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.meetingName, meetingName) ||
                other.meetingName == meetingName) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.isAttended, isAttended) ||
                other.isAttended == isAttended) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, meetingName, submittedAt, isAttended, isOpen);

  /// Create a copy of MeetingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetingsEntityImplCopyWith<_$MeetingsEntityImpl> get copyWith =>
      __$$MeetingsEntityImplCopyWithImpl<_$MeetingsEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingsEntityImplToJson(
      this,
    );
  }
}

abstract class _MeetingsEntity extends MeetingsEntity {
  const factory _MeetingsEntity(
      {final String? id,
      final String? meetingName,
      final String? submittedAt,
      final bool? isAttended,
      final bool? isOpen}) = _$MeetingsEntityImpl;
  const _MeetingsEntity._() : super._();

  factory _MeetingsEntity.fromJson(Map<String, dynamic> json) =
      _$MeetingsEntityImpl.fromJson;

  @override
  String? get id;
  @override
  String? get meetingName;
  @override
  String? get submittedAt;
  @override
  bool? get isAttended;
  @override
  bool? get isOpen;

  /// Create a copy of MeetingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeetingsEntityImplCopyWith<_$MeetingsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
