// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classmate_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClassmateEntity _$ClassmateEntityFromJson(Map<String, dynamic> json) {
  return _ClassmateEntity.fromJson(json);
}

/// @nodoc
mixin _$ClassmateEntity {
  String? get name => throw _privateConstructorUsedError;
  bool? get is_me => throw _privateConstructorUsedError;

  /// Serializes this ClassmateEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassmateEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassmateEntityCopyWith<ClassmateEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassmateEntityCopyWith<$Res> {
  factory $ClassmateEntityCopyWith(
          ClassmateEntity value, $Res Function(ClassmateEntity) then) =
      _$ClassmateEntityCopyWithImpl<$Res, ClassmateEntity>;
  @useResult
  $Res call({String? name, bool? is_me});
}

/// @nodoc
class _$ClassmateEntityCopyWithImpl<$Res, $Val extends ClassmateEntity>
    implements $ClassmateEntityCopyWith<$Res> {
  _$ClassmateEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassmateEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? is_me = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      is_me: freezed == is_me
          ? _value.is_me
          : is_me // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassmateEntityImplCopyWith<$Res>
    implements $ClassmateEntityCopyWith<$Res> {
  factory _$$ClassmateEntityImplCopyWith(_$ClassmateEntityImpl value,
          $Res Function(_$ClassmateEntityImpl) then) =
      __$$ClassmateEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, bool? is_me});
}

/// @nodoc
class __$$ClassmateEntityImplCopyWithImpl<$Res>
    extends _$ClassmateEntityCopyWithImpl<$Res, _$ClassmateEntityImpl>
    implements _$$ClassmateEntityImplCopyWith<$Res> {
  __$$ClassmateEntityImplCopyWithImpl(
      _$ClassmateEntityImpl _value, $Res Function(_$ClassmateEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClassmateEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? is_me = freezed,
  }) {
    return _then(_$ClassmateEntityImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      is_me: freezed == is_me
          ? _value.is_me
          : is_me // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassmateEntityImpl implements _ClassmateEntity {
  const _$ClassmateEntityImpl({this.name, this.is_me});

  factory _$ClassmateEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassmateEntityImplFromJson(json);

  @override
  final String? name;
  @override
  final bool? is_me;

  @override
  String toString() {
    return 'ClassmateEntity(name: $name, is_me: $is_me)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassmateEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.is_me, is_me) || other.is_me == is_me));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, is_me);

  /// Create a copy of ClassmateEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassmateEntityImplCopyWith<_$ClassmateEntityImpl> get copyWith =>
      __$$ClassmateEntityImplCopyWithImpl<_$ClassmateEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassmateEntityImplToJson(
      this,
    );
  }
}

abstract class _ClassmateEntity implements ClassmateEntity {
  const factory _ClassmateEntity({final String? name, final bool? is_me}) =
      _$ClassmateEntityImpl;

  factory _ClassmateEntity.fromJson(Map<String, dynamic> json) =
      _$ClassmateEntityImpl.fromJson;

  @override
  String? get name;
  @override
  bool? get is_me;

  /// Create a copy of ClassmateEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassmateEntityImplCopyWith<_$ClassmateEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
