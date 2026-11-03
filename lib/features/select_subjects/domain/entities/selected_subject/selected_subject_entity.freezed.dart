// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_subject_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectedSubjectEntity {

@JsonKey(name: 'id') String? get activationId; bool? get status; String? get createdAt; String? get subjectId; List<SelectedSubjectSubjectsEntity>? get subjects; ActivationClassEntity? get registeredClass; List<ActivationClassEntity>? get availableClasses;
/// Create a copy of SelectedSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedSubjectEntityCopyWith<SelectedSubjectEntity> get copyWith => _$SelectedSubjectEntityCopyWithImpl<SelectedSubjectEntity>(this as SelectedSubjectEntity, _$identity);

  /// Serializes this SelectedSubjectEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SelectedSubjectEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedSubjectEntity&&(identical(other.activationId, _this.activationId) || other.activationId == _this.activationId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId)&&const DeepCollectionEquality().equals(other.subjects, _this.subjects)&&(identical(other.registeredClass, _this.registeredClass) || other.registeredClass == _this.registeredClass)&&const DeepCollectionEquality().equals(other.availableClasses, _this.availableClasses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SelectedSubjectEntity;
  return Object.hash(runtimeType,_this.activationId,_this.status,_this.createdAt,_this.subjectId,const DeepCollectionEquality().hash(_this.subjects),_this.registeredClass,const DeepCollectionEquality().hash(_this.availableClasses));
}

@override
String toString() {
  final _this = this as SelectedSubjectEntity;
  return 'SelectedSubjectEntity(activationId: ${_this.activationId}, status: ${_this.status}, createdAt: ${_this.createdAt}, subjectId: ${_this.subjectId}, subjects: ${_this.subjects}, registeredClass: ${_this.registeredClass}, availableClasses: ${_this.availableClasses})';
}


}

/// @nodoc
abstract mixin class $SelectedSubjectEntityCopyWith<$Res>  {
  factory $SelectedSubjectEntityCopyWith(SelectedSubjectEntity value, $Res Function(SelectedSubjectEntity) _then) = _$SelectedSubjectEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String? activationId, bool? status, String? createdAt, String? subjectId, List<SelectedSubjectSubjectsEntity>? subjects, ActivationClassEntity? registeredClass, List<ActivationClassEntity>? availableClasses
});


$ActivationClassEntityCopyWith<$Res>? get registeredClass;

}
/// @nodoc
class _$SelectedSubjectEntityCopyWithImpl<$Res>
    implements $SelectedSubjectEntityCopyWith<$Res> {
  _$SelectedSubjectEntityCopyWithImpl(this._self, this._then);

  final SelectedSubjectEntity _self;
  final $Res Function(SelectedSubjectEntity) _then;

/// Create a copy of SelectedSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activationId = freezed,Object? status = freezed,Object? createdAt = freezed,Object? subjectId = freezed,Object? subjects = freezed,Object? registeredClass = freezed,Object? availableClasses = freezed,}) {
  return _then(SelectedSubjectEntity(
activationId: freezed == activationId ? _self.activationId : activationId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,subjects: freezed == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<SelectedSubjectSubjectsEntity>?,registeredClass: freezed == registeredClass ? _self.registeredClass : registeredClass // ignore: cast_nullable_to_non_nullable
as ActivationClassEntity?,availableClasses: freezed == availableClasses ? _self.availableClasses : availableClasses // ignore: cast_nullable_to_non_nullable
as List<ActivationClassEntity>?,
  ));
}
/// Create a copy of SelectedSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivationClassEntityCopyWith<$Res>? get registeredClass {
    if (_self.registeredClass == null) {
    return null;
  }

  return $ActivationClassEntityCopyWith<$Res>(_self.registeredClass!, (value) {
    return _then(_self.copyWith(registeredClass: value));
  });
}
}


/// Adds pattern-matching-related methods to [SelectedSubjectEntity].
extension SelectedSubjectEntityPatterns on SelectedSubjectEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectedSubjectEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectedSubjectEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectedSubjectEntity value)  $default,){
final _that = this;
switch (_that) {
case _SelectedSubjectEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectedSubjectEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SelectedSubjectEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? activationId,  bool? status,  String? createdAt,  String? subjectId,  List<SelectedSubjectSubjectsEntity>? subjects,  ActivationClassEntity? registeredClass,  List<ActivationClassEntity>? availableClasses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectedSubjectEntity() when $default != null:
return $default(_that.activationId,_that.status,_that.createdAt,_that.subjectId,_that.subjects,_that.registeredClass,_that.availableClasses);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? activationId,  bool? status,  String? createdAt,  String? subjectId,  List<SelectedSubjectSubjectsEntity>? subjects,  ActivationClassEntity? registeredClass,  List<ActivationClassEntity>? availableClasses)  $default,) {final _that = this;
switch (_that) {
case _SelectedSubjectEntity():
return $default(_that.activationId,_that.status,_that.createdAt,_that.subjectId,_that.subjects,_that.registeredClass,_that.availableClasses);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String? activationId,  bool? status,  String? createdAt,  String? subjectId,  List<SelectedSubjectSubjectsEntity>? subjects,  ActivationClassEntity? registeredClass,  List<ActivationClassEntity>? availableClasses)?  $default,) {final _that = this;
switch (_that) {
case _SelectedSubjectEntity() when $default != null:
return $default(_that.activationId,_that.status,_that.createdAt,_that.subjectId,_that.subjects,_that.registeredClass,_that.availableClasses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectedSubjectEntity implements SelectedSubjectEntity {
  const _SelectedSubjectEntity({@JsonKey(name: 'id') this.activationId, this.status, this.createdAt, this.subjectId,  List<SelectedSubjectSubjectsEntity>? subjects, this.registeredClass,  List<ActivationClassEntity>? availableClasses}): _subjects = subjects,_availableClasses = availableClasses;
  factory _SelectedSubjectEntity.fromJson(Map<String, dynamic> json) => _$SelectedSubjectEntityFromJson(json);

@override@JsonKey(name: 'id') final  String? activationId;
@override final  bool? status;
@override final  String? createdAt;
@override final  String? subjectId;
 final  List<SelectedSubjectSubjectsEntity>? _subjects;
@override List<SelectedSubjectSubjectsEntity>? get subjects {
  final value = _subjects;
  if (value == null) return null;
  if (_subjects is EqualUnmodifiableListView) return _subjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  ActivationClassEntity? registeredClass;
 final  List<ActivationClassEntity>? _availableClasses;
@override List<ActivationClassEntity>? get availableClasses {
  final value = _availableClasses;
  if (value == null) return null;
  if (_availableClasses is EqualUnmodifiableListView) return _availableClasses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SelectedSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedSubjectEntityCopyWith<_SelectedSubjectEntity> get copyWith => __$SelectedSubjectEntityCopyWithImpl<_SelectedSubjectEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectedSubjectEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedSubjectEntity&&(identical(other.activationId, activationId) || other.activationId == activationId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&const DeepCollectionEquality().equals(other.subjects, _subjects)&&(identical(other.registeredClass, registeredClass) || other.registeredClass == registeredClass)&&const DeepCollectionEquality().equals(other.availableClasses, _availableClasses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activationId,status,createdAt,subjectId,const DeepCollectionEquality().hash(_subjects),registeredClass,const DeepCollectionEquality().hash(_availableClasses));
}

@override
String toString() {
    return 'SelectedSubjectEntity(activationId: $activationId, status: $status, createdAt: $createdAt, subjectId: $subjectId, subjects: $subjects, registeredClass: $registeredClass, availableClasses: $availableClasses)';
}


}

/// @nodoc
abstract mixin class _$SelectedSubjectEntityCopyWith<$Res> implements $SelectedSubjectEntityCopyWith<$Res> {
  factory _$SelectedSubjectEntityCopyWith(_SelectedSubjectEntity value, $Res Function(_SelectedSubjectEntity) _then) = __$SelectedSubjectEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String? activationId, bool? status, String? createdAt, String? subjectId, List<SelectedSubjectSubjectsEntity>? subjects, ActivationClassEntity? registeredClass, List<ActivationClassEntity>? availableClasses
});


@override $ActivationClassEntityCopyWith<$Res>? get registeredClass;

}
/// @nodoc
class __$SelectedSubjectEntityCopyWithImpl<$Res>
    implements _$SelectedSubjectEntityCopyWith<$Res> {
  __$SelectedSubjectEntityCopyWithImpl(this._self, this._then);

  final _SelectedSubjectEntity _self;
  final $Res Function(_SelectedSubjectEntity) _then;

/// Create a copy of SelectedSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activationId = freezed,Object? status = freezed,Object? createdAt = freezed,Object? subjectId = freezed,Object? subjects = freezed,Object? registeredClass = freezed,Object? availableClasses = freezed,}) {
  return _then(_SelectedSubjectEntity(
activationId: freezed == activationId ? _self.activationId : activationId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,subjects: freezed == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<SelectedSubjectSubjectsEntity>?,registeredClass: freezed == registeredClass ? _self.registeredClass : registeredClass // ignore: cast_nullable_to_non_nullable
as ActivationClassEntity?,availableClasses: freezed == availableClasses ? _self._availableClasses : availableClasses // ignore: cast_nullable_to_non_nullable
as List<ActivationClassEntity>?,
  ));
}

/// Create a copy of SelectedSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivationClassEntityCopyWith<$Res>? get registeredClass {
    if (_self.registeredClass == null) {
    return null;
  }

  return $ActivationClassEntityCopyWith<$Res>(_self.registeredClass!, (value) {
    return _then(_self.copyWith(registeredClass: value));
  });
}
}

// dart format on
