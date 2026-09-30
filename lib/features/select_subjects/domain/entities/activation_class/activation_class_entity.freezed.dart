// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activation_class_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActivationClassEntity _$ActivationClassEntityFromJson(
    Map<String, dynamic> json) {
  return _ActivationClassEntity.fromJson(json);
}

/// @nodoc
mixin _$ActivationClassEntity {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get day => throw _privateConstructorUsedError;
  String? get session_time => throw _privateConstructorUsedError;

  /// Serializes this ActivationClassEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivationClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivationClassEntityCopyWith<ActivationClassEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivationClassEntityCopyWith<$Res> {
  factory $ActivationClassEntityCopyWith(ActivationClassEntity value,
          $Res Function(ActivationClassEntity) then) =
      _$ActivationClassEntityCopyWithImpl<$Res, ActivationClassEntity>;
  @useResult
  $Res call({String? id, String? name, String? day, String? session_time});
}

/// @nodoc
class _$ActivationClassEntityCopyWithImpl<$Res,
        $Val extends ActivationClassEntity>
    implements $ActivationClassEntityCopyWith<$Res> {
  _$ActivationClassEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivationClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? day = freezed,
    Object? session_time = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String?,
      session_time: freezed == session_time
          ? _value.session_time
          : session_time // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivationClassEntityImplCopyWith<$Res>
    implements $ActivationClassEntityCopyWith<$Res> {
  factory _$$ActivationClassEntityImplCopyWith(
          _$ActivationClassEntityImpl value,
          $Res Function(_$ActivationClassEntityImpl) then) =
      __$$ActivationClassEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name, String? day, String? session_time});
}

/// @nodoc
class __$$ActivationClassEntityImplCopyWithImpl<$Res>
    extends _$ActivationClassEntityCopyWithImpl<$Res,
        _$ActivationClassEntityImpl>
    implements _$$ActivationClassEntityImplCopyWith<$Res> {
  __$$ActivationClassEntityImplCopyWithImpl(_$ActivationClassEntityImpl _value,
      $Res Function(_$ActivationClassEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivationClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? day = freezed,
    Object? session_time = freezed,
  }) {
    return _then(_$ActivationClassEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String?,
      session_time: freezed == session_time
          ? _value.session_time
          : session_time // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivationClassEntityImpl implements _ActivationClassEntity {
  const _$ActivationClassEntityImpl(
      {this.id, this.name, this.day, this.session_time});

  factory _$ActivationClassEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivationClassEntityImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? day;
  @override
  final String? session_time;

  @override
  String toString() {
    return 'ActivationClassEntity(id: $id, name: $name, day: $day, session_time: $session_time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivationClassEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.session_time, session_time) ||
                other.session_time == session_time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, day, session_time);

  /// Create a copy of ActivationClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivationClassEntityImplCopyWith<_$ActivationClassEntityImpl>
      get copyWith => __$$ActivationClassEntityImplCopyWithImpl<
          _$ActivationClassEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivationClassEntityImplToJson(
      this,
    );
  }
}

abstract class _ActivationClassEntity implements ActivationClassEntity {
  const factory _ActivationClassEntity(
      {final String? id,
      final String? name,
      final String? day,
      final String? session_time}) = _$ActivationClassEntityImpl;

  factory _ActivationClassEntity.fromJson(Map<String, dynamic> json) =
      _$ActivationClassEntityImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get day;
  @override
  String? get session_time;

  /// Create a copy of ActivationClassEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivationClassEntityImplCopyWith<_$ActivationClassEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
