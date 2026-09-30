// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_subject_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SelectedSubjectEntity _$SelectedSubjectEntityFromJson(
    Map<String, dynamic> json) {
  return _SelectedSubjectEntity.fromJson(json);
}

/// @nodoc
mixin _$SelectedSubjectEntity {
  @JsonKey(name: 'id')
  String? get activation_id => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;
  String? get subject_id => throw _privateConstructorUsedError;
  List<SelectedSubjectSubjectsEntity>? get subjects =>
      throw _privateConstructorUsedError;
  ActivationClassEntity? get registered_class =>
      throw _privateConstructorUsedError;
  List<ActivationClassEntity>? get available_classes =>
      throw _privateConstructorUsedError;

  /// Serializes this SelectedSubjectEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelectedSubjectEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedSubjectEntityCopyWith<SelectedSubjectEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedSubjectEntityCopyWith<$Res> {
  factory $SelectedSubjectEntityCopyWith(SelectedSubjectEntity value,
          $Res Function(SelectedSubjectEntity) then) =
      _$SelectedSubjectEntityCopyWithImpl<$Res, SelectedSubjectEntity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? activation_id,
      bool? status,
      String? created_at,
      String? subject_id,
      List<SelectedSubjectSubjectsEntity>? subjects,
      ActivationClassEntity? registered_class,
      List<ActivationClassEntity>? available_classes});

  $ActivationClassEntityCopyWith<$Res>? get registered_class;
}

/// @nodoc
class _$SelectedSubjectEntityCopyWithImpl<$Res,
        $Val extends SelectedSubjectEntity>
    implements $SelectedSubjectEntityCopyWith<$Res> {
  _$SelectedSubjectEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedSubjectEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activation_id = freezed,
    Object? status = freezed,
    Object? created_at = freezed,
    Object? subject_id = freezed,
    Object? subjects = freezed,
    Object? registered_class = freezed,
    Object? available_classes = freezed,
  }) {
    return _then(_value.copyWith(
      activation_id: freezed == activation_id
          ? _value.activation_id
          : activation_id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      subject_id: freezed == subject_id
          ? _value.subject_id
          : subject_id // ignore: cast_nullable_to_non_nullable
              as String?,
      subjects: freezed == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<SelectedSubjectSubjectsEntity>?,
      registered_class: freezed == registered_class
          ? _value.registered_class
          : registered_class // ignore: cast_nullable_to_non_nullable
              as ActivationClassEntity?,
      available_classes: freezed == available_classes
          ? _value.available_classes
          : available_classes // ignore: cast_nullable_to_non_nullable
              as List<ActivationClassEntity>?,
    ) as $Val);
  }

  /// Create a copy of SelectedSubjectEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivationClassEntityCopyWith<$Res>? get registered_class {
    if (_value.registered_class == null) {
      return null;
    }

    return $ActivationClassEntityCopyWith<$Res>(_value.registered_class!,
        (value) {
      return _then(_value.copyWith(registered_class: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SelectedSubjectEntityImplCopyWith<$Res>
    implements $SelectedSubjectEntityCopyWith<$Res> {
  factory _$$SelectedSubjectEntityImplCopyWith(
          _$SelectedSubjectEntityImpl value,
          $Res Function(_$SelectedSubjectEntityImpl) then) =
      __$$SelectedSubjectEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? activation_id,
      bool? status,
      String? created_at,
      String? subject_id,
      List<SelectedSubjectSubjectsEntity>? subjects,
      ActivationClassEntity? registered_class,
      List<ActivationClassEntity>? available_classes});

  @override
  $ActivationClassEntityCopyWith<$Res>? get registered_class;
}

/// @nodoc
class __$$SelectedSubjectEntityImplCopyWithImpl<$Res>
    extends _$SelectedSubjectEntityCopyWithImpl<$Res,
        _$SelectedSubjectEntityImpl>
    implements _$$SelectedSubjectEntityImplCopyWith<$Res> {
  __$$SelectedSubjectEntityImplCopyWithImpl(_$SelectedSubjectEntityImpl _value,
      $Res Function(_$SelectedSubjectEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectedSubjectEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activation_id = freezed,
    Object? status = freezed,
    Object? created_at = freezed,
    Object? subject_id = freezed,
    Object? subjects = freezed,
    Object? registered_class = freezed,
    Object? available_classes = freezed,
  }) {
    return _then(_$SelectedSubjectEntityImpl(
      activation_id: freezed == activation_id
          ? _value.activation_id
          : activation_id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      subject_id: freezed == subject_id
          ? _value.subject_id
          : subject_id // ignore: cast_nullable_to_non_nullable
              as String?,
      subjects: freezed == subjects
          ? _value._subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<SelectedSubjectSubjectsEntity>?,
      registered_class: freezed == registered_class
          ? _value.registered_class
          : registered_class // ignore: cast_nullable_to_non_nullable
              as ActivationClassEntity?,
      available_classes: freezed == available_classes
          ? _value._available_classes
          : available_classes // ignore: cast_nullable_to_non_nullable
              as List<ActivationClassEntity>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectedSubjectEntityImpl implements _SelectedSubjectEntity {
  const _$SelectedSubjectEntityImpl(
      {@JsonKey(name: 'id') this.activation_id,
      this.status,
      this.created_at,
      this.subject_id,
      final List<SelectedSubjectSubjectsEntity>? subjects,
      this.registered_class,
      final List<ActivationClassEntity>? available_classes})
      : _subjects = subjects,
        _available_classes = available_classes;

  factory _$SelectedSubjectEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectedSubjectEntityImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? activation_id;
  @override
  final bool? status;
  @override
  final String? created_at;
  @override
  final String? subject_id;
  final List<SelectedSubjectSubjectsEntity>? _subjects;
  @override
  List<SelectedSubjectSubjectsEntity>? get subjects {
    final value = _subjects;
    if (value == null) return null;
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ActivationClassEntity? registered_class;
  final List<ActivationClassEntity>? _available_classes;
  @override
  List<ActivationClassEntity>? get available_classes {
    final value = _available_classes;
    if (value == null) return null;
    if (_available_classes is EqualUnmodifiableListView)
      return _available_classes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SelectedSubjectEntity(activation_id: $activation_id, status: $status, created_at: $created_at, subject_id: $subject_id, subjects: $subjects, registered_class: $registered_class, available_classes: $available_classes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedSubjectEntityImpl &&
            (identical(other.activation_id, activation_id) ||
                other.activation_id == activation_id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.subject_id, subject_id) ||
                other.subject_id == subject_id) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects) &&
            (identical(other.registered_class, registered_class) ||
                other.registered_class == registered_class) &&
            const DeepCollectionEquality()
                .equals(other._available_classes, _available_classes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activation_id,
      status,
      created_at,
      subject_id,
      const DeepCollectionEquality().hash(_subjects),
      registered_class,
      const DeepCollectionEquality().hash(_available_classes));

  /// Create a copy of SelectedSubjectEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedSubjectEntityImplCopyWith<_$SelectedSubjectEntityImpl>
      get copyWith => __$$SelectedSubjectEntityImplCopyWithImpl<
          _$SelectedSubjectEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectedSubjectEntityImplToJson(
      this,
    );
  }
}

abstract class _SelectedSubjectEntity implements SelectedSubjectEntity {
  const factory _SelectedSubjectEntity(
          {@JsonKey(name: 'id') final String? activation_id,
          final bool? status,
          final String? created_at,
          final String? subject_id,
          final List<SelectedSubjectSubjectsEntity>? subjects,
          final ActivationClassEntity? registered_class,
          final List<ActivationClassEntity>? available_classes}) =
      _$SelectedSubjectEntityImpl;

  factory _SelectedSubjectEntity.fromJson(Map<String, dynamic> json) =
      _$SelectedSubjectEntityImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get activation_id;
  @override
  bool? get status;
  @override
  String? get created_at;
  @override
  String? get subject_id;
  @override
  List<SelectedSubjectSubjectsEntity>? get subjects;
  @override
  ActivationClassEntity? get registered_class;
  @override
  List<ActivationClassEntity>? get available_classes;

  /// Create a copy of SelectedSubjectEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedSubjectEntityImplCopyWith<_$SelectedSubjectEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
