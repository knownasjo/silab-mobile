// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_class_option_by_paid_subject_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserClassOptionByPaidSubjectEntity {

@JsonKey(name: 'id') String? get classId; String? get subjectName; String? get subjectClass; String? get semester; String? get sessionTime; int? get quota; int? get registeredStudents; String? get day;
/// Create a copy of UserClassOptionByPaidSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserClassOptionByPaidSubjectEntityCopyWith<UserClassOptionByPaidSubjectEntity> get copyWith => _$UserClassOptionByPaidSubjectEntityCopyWithImpl<UserClassOptionByPaidSubjectEntity>(this as UserClassOptionByPaidSubjectEntity, _$identity);

  /// Serializes this UserClassOptionByPaidSubjectEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserClassOptionByPaidSubjectEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserClassOptionByPaidSubjectEntity&&(identical(other.classId, _this.classId) || other.classId == _this.classId)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.subjectClass, _this.subjectClass) || other.subjectClass == _this.subjectClass)&&(identical(other.semester, _this.semester) || other.semester == _this.semester)&&(identical(other.sessionTime, _this.sessionTime) || other.sessionTime == _this.sessionTime)&&(identical(other.quota, _this.quota) || other.quota == _this.quota)&&(identical(other.registeredStudents, _this.registeredStudents) || other.registeredStudents == _this.registeredStudents)&&(identical(other.day, _this.day) || other.day == _this.day));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserClassOptionByPaidSubjectEntity;
  return Object.hash(runtimeType,_this.classId,_this.subjectName,_this.subjectClass,_this.semester,_this.sessionTime,_this.quota,_this.registeredStudents,_this.day);
}

@override
String toString() {
  final _this = this as UserClassOptionByPaidSubjectEntity;
  return 'UserClassOptionByPaidSubjectEntity(classId: ${_this.classId}, subjectName: ${_this.subjectName}, subjectClass: ${_this.subjectClass}, semester: ${_this.semester}, sessionTime: ${_this.sessionTime}, quota: ${_this.quota}, registeredStudents: ${_this.registeredStudents}, day: ${_this.day})';
}


}

/// @nodoc
abstract mixin class $UserClassOptionByPaidSubjectEntityCopyWith<$Res>  {
  factory $UserClassOptionByPaidSubjectEntityCopyWith(UserClassOptionByPaidSubjectEntity value, $Res Function(UserClassOptionByPaidSubjectEntity) _then) = _$UserClassOptionByPaidSubjectEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String? classId, String? subjectName, String? subjectClass, String? semester, String? sessionTime, int? quota, int? registeredStudents, String? day
});




}
/// @nodoc
class _$UserClassOptionByPaidSubjectEntityCopyWithImpl<$Res>
    implements $UserClassOptionByPaidSubjectEntityCopyWith<$Res> {
  _$UserClassOptionByPaidSubjectEntityCopyWithImpl(this._self, this._then);

  final UserClassOptionByPaidSubjectEntity _self;
  final $Res Function(UserClassOptionByPaidSubjectEntity) _then;

/// Create a copy of UserClassOptionByPaidSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classId = freezed,Object? subjectName = freezed,Object? subjectClass = freezed,Object? semester = freezed,Object? sessionTime = freezed,Object? quota = freezed,Object? registeredStudents = freezed,Object? day = freezed,}) {
  return _then(UserClassOptionByPaidSubjectEntity(
classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,subjectClass: freezed == subjectClass ? _self.subjectClass : subjectClass // ignore: cast_nullable_to_non_nullable
as String?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,sessionTime: freezed == sessionTime ? _self.sessionTime : sessionTime // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as int?,registeredStudents: freezed == registeredStudents ? _self.registeredStudents : registeredStudents // ignore: cast_nullable_to_non_nullable
as int?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserClassOptionByPaidSubjectEntity].
extension UserClassOptionByPaidSubjectEntityPatterns on UserClassOptionByPaidSubjectEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserClassOptionByPaidSubjectEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserClassOptionByPaidSubjectEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserClassOptionByPaidSubjectEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? classId,  String? subjectName,  String? subjectClass,  String? semester,  String? sessionTime,  int? quota,  int? registeredStudents,  String? day)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectEntity() when $default != null:
return $default(_that.classId,_that.subjectName,_that.subjectClass,_that.semester,_that.sessionTime,_that.quota,_that.registeredStudents,_that.day);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? classId,  String? subjectName,  String? subjectClass,  String? semester,  String? sessionTime,  int? quota,  int? registeredStudents,  String? day)  $default,) {final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectEntity():
return $default(_that.classId,_that.subjectName,_that.subjectClass,_that.semester,_that.sessionTime,_that.quota,_that.registeredStudents,_that.day);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String? classId,  String? subjectName,  String? subjectClass,  String? semester,  String? sessionTime,  int? quota,  int? registeredStudents,  String? day)?  $default,) {final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectEntity() when $default != null:
return $default(_that.classId,_that.subjectName,_that.subjectClass,_that.semester,_that.sessionTime,_that.quota,_that.registeredStudents,_that.day);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserClassOptionByPaidSubjectEntity implements UserClassOptionByPaidSubjectEntity {
  const _UserClassOptionByPaidSubjectEntity({@JsonKey(name: 'id') this.classId, this.subjectName, this.subjectClass, this.semester, this.sessionTime, this.quota, this.registeredStudents, this.day});
  factory _UserClassOptionByPaidSubjectEntity.fromJson(Map<String, dynamic> json) => _$UserClassOptionByPaidSubjectEntityFromJson(json);

@override@JsonKey(name: 'id') final  String? classId;
@override final  String? subjectName;
@override final  String? subjectClass;
@override final  String? semester;
@override final  String? sessionTime;
@override final  int? quota;
@override final  int? registeredStudents;
@override final  String? day;

/// Create a copy of UserClassOptionByPaidSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserClassOptionByPaidSubjectEntityCopyWith<_UserClassOptionByPaidSubjectEntity> get copyWith => __$UserClassOptionByPaidSubjectEntityCopyWithImpl<_UserClassOptionByPaidSubjectEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserClassOptionByPaidSubjectEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserClassOptionByPaidSubjectEntity&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.subjectClass, subjectClass) || other.subjectClass == subjectClass)&&(identical(other.semester, semester) || other.semester == semester)&&(identical(other.sessionTime, sessionTime) || other.sessionTime == sessionTime)&&(identical(other.quota, quota) || other.quota == quota)&&(identical(other.registeredStudents, registeredStudents) || other.registeredStudents == registeredStudents)&&(identical(other.day, day) || other.day == day));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,classId,subjectName,subjectClass,semester,sessionTime,quota,registeredStudents,day);
}

@override
String toString() {
    return 'UserClassOptionByPaidSubjectEntity(classId: $classId, subjectName: $subjectName, subjectClass: $subjectClass, semester: $semester, sessionTime: $sessionTime, quota: $quota, registeredStudents: $registeredStudents, day: $day)';
}


}

/// @nodoc
abstract mixin class _$UserClassOptionByPaidSubjectEntityCopyWith<$Res> implements $UserClassOptionByPaidSubjectEntityCopyWith<$Res> {
  factory _$UserClassOptionByPaidSubjectEntityCopyWith(_UserClassOptionByPaidSubjectEntity value, $Res Function(_UserClassOptionByPaidSubjectEntity) _then) = __$UserClassOptionByPaidSubjectEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String? classId, String? subjectName, String? subjectClass, String? semester, String? sessionTime, int? quota, int? registeredStudents, String? day
});




}
/// @nodoc
class __$UserClassOptionByPaidSubjectEntityCopyWithImpl<$Res>
    implements _$UserClassOptionByPaidSubjectEntityCopyWith<$Res> {
  __$UserClassOptionByPaidSubjectEntityCopyWithImpl(this._self, this._then);

  final _UserClassOptionByPaidSubjectEntity _self;
  final $Res Function(_UserClassOptionByPaidSubjectEntity) _then;

/// Create a copy of UserClassOptionByPaidSubjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classId = freezed,Object? subjectName = freezed,Object? subjectClass = freezed,Object? semester = freezed,Object? sessionTime = freezed,Object? quota = freezed,Object? registeredStudents = freezed,Object? day = freezed,}) {
  return _then(_UserClassOptionByPaidSubjectEntity(
classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,subjectClass: freezed == subjectClass ? _self.subjectClass : subjectClass // ignore: cast_nullable_to_non_nullable
as String?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,sessionTime: freezed == sessionTime ? _self.sessionTime : sessionTime // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as int?,registeredStudents: freezed == registeredStudents ? _self.registeredStudents : registeredStudents // ignore: cast_nullable_to_non_nullable
as int?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
