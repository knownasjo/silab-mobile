// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practicums_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PracticumsEntity _$PracticumsEntityFromJson(Map<String, dynamic> json) {
  return _PracticumsEntity.fromJson(json);
}

/// @nodoc
mixin _$PracticumsEntity {
  String? get subject_name => throw _privateConstructorUsedError;
  String? get subject_class => throw _privateConstructorUsedError;
  String? get session => throw _privateConstructorUsedError;
  String? get class_id => throw _privateConstructorUsedError;
  String? get room => throw _privateConstructorUsedError;
  bool? get is_assistant => throw _privateConstructorUsedError;
  ClassEntity? get class_entity => throw _privateConstructorUsedError;

  /// Serializes this PracticumsEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PracticumsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PracticumsEntityCopyWith<PracticumsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PracticumsEntityCopyWith<$Res> {
  factory $PracticumsEntityCopyWith(
          PracticumsEntity value, $Res Function(PracticumsEntity) then) =
      _$PracticumsEntityCopyWithImpl<$Res, PracticumsEntity>;
  @useResult
  $Res call(
      {String? subject_name,
      String? subject_class,
      String? session,
      String? class_id,
      String? room,
      bool? is_assistant,
      ClassEntity? class_entity});

  $ClassEntityCopyWith<$Res>? get class_entity;
}

/// @nodoc
class _$PracticumsEntityCopyWithImpl<$Res, $Val extends PracticumsEntity>
    implements $PracticumsEntityCopyWith<$Res> {
  _$PracticumsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PracticumsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject_name = freezed,
    Object? subject_class = freezed,
    Object? session = freezed,
    Object? class_id = freezed,
    Object? room = freezed,
    Object? is_assistant = freezed,
    Object? class_entity = freezed,
  }) {
    return _then(_value.copyWith(
      subject_name: freezed == subject_name
          ? _value.subject_name
          : subject_name // ignore: cast_nullable_to_non_nullable
              as String?,
      subject_class: freezed == subject_class
          ? _value.subject_class
          : subject_class // ignore: cast_nullable_to_non_nullable
              as String?,
      session: freezed == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String?,
      class_id: freezed == class_id
          ? _value.class_id
          : class_id // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
      is_assistant: freezed == is_assistant
          ? _value.is_assistant
          : is_assistant // ignore: cast_nullable_to_non_nullable
              as bool?,
      class_entity: freezed == class_entity
          ? _value.class_entity
          : class_entity // ignore: cast_nullable_to_non_nullable
              as ClassEntity?,
    ) as $Val);
  }

  /// Create a copy of PracticumsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClassEntityCopyWith<$Res>? get class_entity {
    if (_value.class_entity == null) {
      return null;
    }

    return $ClassEntityCopyWith<$Res>(_value.class_entity!, (value) {
      return _then(_value.copyWith(class_entity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PracticumsEntityImplCopyWith<$Res>
    implements $PracticumsEntityCopyWith<$Res> {
  factory _$$PracticumsEntityImplCopyWith(_$PracticumsEntityImpl value,
          $Res Function(_$PracticumsEntityImpl) then) =
      __$$PracticumsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? subject_name,
      String? subject_class,
      String? session,
      String? class_id,
      String? room,
      bool? is_assistant,
      ClassEntity? class_entity});

  @override
  $ClassEntityCopyWith<$Res>? get class_entity;
}

/// @nodoc
class __$$PracticumsEntityImplCopyWithImpl<$Res>
    extends _$PracticumsEntityCopyWithImpl<$Res, _$PracticumsEntityImpl>
    implements _$$PracticumsEntityImplCopyWith<$Res> {
  __$$PracticumsEntityImplCopyWithImpl(_$PracticumsEntityImpl _value,
      $Res Function(_$PracticumsEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of PracticumsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject_name = freezed,
    Object? subject_class = freezed,
    Object? session = freezed,
    Object? class_id = freezed,
    Object? room = freezed,
    Object? is_assistant = freezed,
    Object? class_entity = freezed,
  }) {
    return _then(_$PracticumsEntityImpl(
      subject_name: freezed == subject_name
          ? _value.subject_name
          : subject_name // ignore: cast_nullable_to_non_nullable
              as String?,
      subject_class: freezed == subject_class
          ? _value.subject_class
          : subject_class // ignore: cast_nullable_to_non_nullable
              as String?,
      session: freezed == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String?,
      class_id: freezed == class_id
          ? _value.class_id
          : class_id // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
      is_assistant: freezed == is_assistant
          ? _value.is_assistant
          : is_assistant // ignore: cast_nullable_to_non_nullable
              as bool?,
      class_entity: freezed == class_entity
          ? _value.class_entity
          : class_entity // ignore: cast_nullable_to_non_nullable
              as ClassEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticumsEntityImpl implements _PracticumsEntity {
  const _$PracticumsEntityImpl(
      {this.subject_name,
      this.subject_class,
      this.session,
      this.class_id,
      this.room,
      this.is_assistant,
      this.class_entity});

  factory _$PracticumsEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticumsEntityImplFromJson(json);

  @override
  final String? subject_name;
  @override
  final String? subject_class;
  @override
  final String? session;
  @override
  final String? class_id;
  @override
  final String? room;
  @override
  final bool? is_assistant;
  @override
  final ClassEntity? class_entity;

  @override
  String toString() {
    return 'PracticumsEntity(subject_name: $subject_name, subject_class: $subject_class, session: $session, class_id: $class_id, room: $room, is_assistant: $is_assistant, class_entity: $class_entity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticumsEntityImpl &&
            (identical(other.subject_name, subject_name) ||
                other.subject_name == subject_name) &&
            (identical(other.subject_class, subject_class) ||
                other.subject_class == subject_class) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.class_id, class_id) ||
                other.class_id == class_id) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.is_assistant, is_assistant) ||
                other.is_assistant == is_assistant) &&
            (identical(other.class_entity, class_entity) ||
                other.class_entity == class_entity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subject_name, subject_class,
      session, class_id, room, is_assistant, class_entity);

  /// Create a copy of PracticumsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PracticumsEntityImplCopyWith<_$PracticumsEntityImpl> get copyWith =>
      __$$PracticumsEntityImplCopyWithImpl<_$PracticumsEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PracticumsEntityImplToJson(
      this,
    );
  }
}

abstract class _PracticumsEntity implements PracticumsEntity {
  const factory _PracticumsEntity(
      {final String? subject_name,
      final String? subject_class,
      final String? session,
      final String? class_id,
      final String? room,
      final bool? is_assistant,
      final ClassEntity? class_entity}) = _$PracticumsEntityImpl;

  factory _PracticumsEntity.fromJson(Map<String, dynamic> json) =
      _$PracticumsEntityImpl.fromJson;

  @override
  String? get subject_name;
  @override
  String? get subject_class;
  @override
  String? get session;
  @override
  String? get class_id;
  @override
  String? get room;
  @override
  bool? get is_assistant;
  @override
  ClassEntity? get class_entity;

  /// Create a copy of PracticumsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticumsEntityImplCopyWith<_$PracticumsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
