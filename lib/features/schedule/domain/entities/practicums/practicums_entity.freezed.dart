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
  String? get subjectName => throw _privateConstructorUsedError;
  String? get subjectClass => throw _privateConstructorUsedError;
  String? get session => throw _privateConstructorUsedError;
  String? get classId => throw _privateConstructorUsedError;
  String? get room => throw _privateConstructorUsedError;
  bool? get isAssistant => throw _privateConstructorUsedError;
  ClassEntity? get classEntity => throw _privateConstructorUsedError;

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
      {String? subjectName,
      String? subjectClass,
      String? session,
      String? classId,
      String? room,
      bool? isAssistant,
      ClassEntity? classEntity});

  $ClassEntityCopyWith<$Res>? get classEntity;
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
    Object? subjectName = freezed,
    Object? subjectClass = freezed,
    Object? session = freezed,
    Object? classId = freezed,
    Object? room = freezed,
    Object? isAssistant = freezed,
    Object? classEntity = freezed,
  }) {
    return _then(_value.copyWith(
      subjectName: freezed == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectClass: freezed == subjectClass
          ? _value.subjectClass
          : subjectClass // ignore: cast_nullable_to_non_nullable
              as String?,
      session: freezed == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
      isAssistant: freezed == isAssistant
          ? _value.isAssistant
          : isAssistant // ignore: cast_nullable_to_non_nullable
              as bool?,
      classEntity: freezed == classEntity
          ? _value.classEntity
          : classEntity // ignore: cast_nullable_to_non_nullable
              as ClassEntity?,
    ) as $Val);
  }

  /// Create a copy of PracticumsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClassEntityCopyWith<$Res>? get classEntity {
    if (_value.classEntity == null) {
      return null;
    }

    return $ClassEntityCopyWith<$Res>(_value.classEntity!, (value) {
      return _then(_value.copyWith(classEntity: value) as $Val);
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
      {String? subjectName,
      String? subjectClass,
      String? session,
      String? classId,
      String? room,
      bool? isAssistant,
      ClassEntity? classEntity});

  @override
  $ClassEntityCopyWith<$Res>? get classEntity;
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
    Object? subjectName = freezed,
    Object? subjectClass = freezed,
    Object? session = freezed,
    Object? classId = freezed,
    Object? room = freezed,
    Object? isAssistant = freezed,
    Object? classEntity = freezed,
  }) {
    return _then(_$PracticumsEntityImpl(
      subjectName: freezed == subjectName
          ? _value.subjectName
          : subjectName // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectClass: freezed == subjectClass
          ? _value.subjectClass
          : subjectClass // ignore: cast_nullable_to_non_nullable
              as String?,
      session: freezed == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _value.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
      isAssistant: freezed == isAssistant
          ? _value.isAssistant
          : isAssistant // ignore: cast_nullable_to_non_nullable
              as bool?,
      classEntity: freezed == classEntity
          ? _value.classEntity
          : classEntity // ignore: cast_nullable_to_non_nullable
              as ClassEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PracticumsEntityImpl implements _PracticumsEntity {
  const _$PracticumsEntityImpl(
      {this.subjectName,
      this.subjectClass,
      this.session,
      this.classId,
      this.room,
      this.isAssistant,
      this.classEntity});

  factory _$PracticumsEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PracticumsEntityImplFromJson(json);

  @override
  final String? subjectName;
  @override
  final String? subjectClass;
  @override
  final String? session;
  @override
  final String? classId;
  @override
  final String? room;
  @override
  final bool? isAssistant;
  @override
  final ClassEntity? classEntity;

  @override
  String toString() {
    return 'PracticumsEntity(subjectName: $subjectName, subjectClass: $subjectClass, session: $session, classId: $classId, room: $room, isAssistant: $isAssistant, classEntity: $classEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PracticumsEntityImpl &&
            (identical(other.subjectName, subjectName) ||
                other.subjectName == subjectName) &&
            (identical(other.subjectClass, subjectClass) ||
                other.subjectClass == subjectClass) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.isAssistant, isAssistant) ||
                other.isAssistant == isAssistant) &&
            (identical(other.classEntity, classEntity) ||
                other.classEntity == classEntity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subjectName, subjectClass,
      session, classId, room, isAssistant, classEntity);

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
      {final String? subjectName,
      final String? subjectClass,
      final String? session,
      final String? classId,
      final String? room,
      final bool? isAssistant,
      final ClassEntity? classEntity}) = _$PracticumsEntityImpl;

  factory _PracticumsEntity.fromJson(Map<String, dynamic> json) =
      _$PracticumsEntityImpl.fromJson;

  @override
  String? get subjectName;
  @override
  String? get subjectClass;
  @override
  String? get session;
  @override
  String? get classId;
  @override
  String? get room;
  @override
  bool? get isAssistant;
  @override
  ClassEntity? get classEntity;

  /// Create a copy of PracticumsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PracticumsEntityImplCopyWith<_$PracticumsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
