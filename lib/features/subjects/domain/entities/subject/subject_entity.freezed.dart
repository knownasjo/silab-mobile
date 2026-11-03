// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectEntity {

 String? get id; String? get subjectName; String? get subjectCode; String? get semester;
/// Create a copy of SubjectEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectEntityCopyWith<SubjectEntity> get copyWith => _$SubjectEntityCopyWithImpl<SubjectEntity>(this as SubjectEntity, _$identity);

  /// Serializes this SubjectEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubjectEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.subjectCode, _this.subjectCode) || other.subjectCode == _this.subjectCode)&&(identical(other.semester, _this.semester) || other.semester == _this.semester));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubjectEntity;
  return Object.hash(runtimeType,_this.id,_this.subjectName,_this.subjectCode,_this.semester);
}

@override
String toString() {
  final _this = this as SubjectEntity;
  return 'SubjectEntity(id: ${_this.id}, subjectName: ${_this.subjectName}, subjectCode: ${_this.subjectCode}, semester: ${_this.semester})';
}


}

/// @nodoc
abstract mixin class $SubjectEntityCopyWith<$Res>  {
  factory $SubjectEntityCopyWith(SubjectEntity value, $Res Function(SubjectEntity) _then) = _$SubjectEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? subjectName, String? subjectCode, String? semester
});




}
/// @nodoc
class _$SubjectEntityCopyWithImpl<$Res>
    implements $SubjectEntityCopyWith<$Res> {
  _$SubjectEntityCopyWithImpl(this._self, this._then);

  final SubjectEntity _self;
  final $Res Function(SubjectEntity) _then;

/// Create a copy of SubjectEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? subjectName = freezed,Object? subjectCode = freezed,Object? semester = freezed,}) {
  return _then(SubjectEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,subjectCode: freezed == subjectCode ? _self.subjectCode : subjectCode // ignore: cast_nullable_to_non_nullable
as String?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubjectEntity].
extension SubjectEntityPatterns on SubjectEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectEntity value)  $default,){
final _that = this;
switch (_that) {
case _SubjectEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? subjectName,  String? subjectCode,  String? semester)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectEntity() when $default != null:
return $default(_that.id,_that.subjectName,_that.subjectCode,_that.semester);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? subjectName,  String? subjectCode,  String? semester)  $default,) {final _that = this;
switch (_that) {
case _SubjectEntity():
return $default(_that.id,_that.subjectName,_that.subjectCode,_that.semester);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? subjectName,  String? subjectCode,  String? semester)?  $default,) {final _that = this;
switch (_that) {
case _SubjectEntity() when $default != null:
return $default(_that.id,_that.subjectName,_that.subjectCode,_that.semester);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubjectEntity implements SubjectEntity {
  const _SubjectEntity({this.id, this.subjectName, this.subjectCode, this.semester});
  factory _SubjectEntity.fromJson(Map<String, dynamic> json) => _$SubjectEntityFromJson(json);

@override final  String? id;
@override final  String? subjectName;
@override final  String? subjectCode;
@override final  String? semester;

/// Create a copy of SubjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectEntityCopyWith<_SubjectEntity> get copyWith => __$SubjectEntityCopyWithImpl<_SubjectEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubjectEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.subjectCode, subjectCode) || other.subjectCode == subjectCode)&&(identical(other.semester, semester) || other.semester == semester));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,subjectName,subjectCode,semester);
}

@override
String toString() {
    return 'SubjectEntity(id: $id, subjectName: $subjectName, subjectCode: $subjectCode, semester: $semester)';
}


}

/// @nodoc
abstract mixin class _$SubjectEntityCopyWith<$Res> implements $SubjectEntityCopyWith<$Res> {
  factory _$SubjectEntityCopyWith(_SubjectEntity value, $Res Function(_SubjectEntity) _then) = __$SubjectEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? subjectName, String? subjectCode, String? semester
});




}
/// @nodoc
class __$SubjectEntityCopyWithImpl<$Res>
    implements _$SubjectEntityCopyWith<$Res> {
  __$SubjectEntityCopyWithImpl(this._self, this._then);

  final _SubjectEntity _self;
  final $Res Function(_SubjectEntity) _then;

/// Create a copy of SubjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? subjectName = freezed,Object? subjectCode = freezed,Object? semester = freezed,}) {
  return _then(_SubjectEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,subjectCode: freezed == subjectCode ? _self.subjectCode : subjectCode // ignore: cast_nullable_to_non_nullable
as String?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
