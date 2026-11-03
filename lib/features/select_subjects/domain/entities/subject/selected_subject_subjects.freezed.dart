// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_subject_subjects.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectedSubjectSubjectsEntity {

 String? get subjectName; String? get semester;
/// Create a copy of SelectedSubjectSubjectsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedSubjectSubjectsEntityCopyWith<SelectedSubjectSubjectsEntity> get copyWith => _$SelectedSubjectSubjectsEntityCopyWithImpl<SelectedSubjectSubjectsEntity>(this as SelectedSubjectSubjectsEntity, _$identity);

  /// Serializes this SelectedSubjectSubjectsEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SelectedSubjectSubjectsEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedSubjectSubjectsEntity&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.semester, _this.semester) || other.semester == _this.semester));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SelectedSubjectSubjectsEntity;
  return Object.hash(runtimeType,_this.subjectName,_this.semester);
}

@override
String toString() {
  final _this = this as SelectedSubjectSubjectsEntity;
  return 'SelectedSubjectSubjectsEntity(subjectName: ${_this.subjectName}, semester: ${_this.semester})';
}


}

/// @nodoc
abstract mixin class $SelectedSubjectSubjectsEntityCopyWith<$Res>  {
  factory $SelectedSubjectSubjectsEntityCopyWith(SelectedSubjectSubjectsEntity value, $Res Function(SelectedSubjectSubjectsEntity) _then) = _$SelectedSubjectSubjectsEntityCopyWithImpl;
@useResult
$Res call({
 String? subjectName, String? semester
});




}
/// @nodoc
class _$SelectedSubjectSubjectsEntityCopyWithImpl<$Res>
    implements $SelectedSubjectSubjectsEntityCopyWith<$Res> {
  _$SelectedSubjectSubjectsEntityCopyWithImpl(this._self, this._then);

  final SelectedSubjectSubjectsEntity _self;
  final $Res Function(SelectedSubjectSubjectsEntity) _then;

/// Create a copy of SelectedSubjectSubjectsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subjectName = freezed,Object? semester = freezed,}) {
  return _then(SelectedSubjectSubjectsEntity(
subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectedSubjectSubjectsEntity].
extension SelectedSubjectSubjectsEntityPatterns on SelectedSubjectSubjectsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectedSubjectSubjectsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectedSubjectSubjectsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectedSubjectSubjectsEntity value)  $default,){
final _that = this;
switch (_that) {
case _SelectedSubjectSubjectsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectedSubjectSubjectsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SelectedSubjectSubjectsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? subjectName,  String? semester)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectedSubjectSubjectsEntity() when $default != null:
return $default(_that.subjectName,_that.semester);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? subjectName,  String? semester)  $default,) {final _that = this;
switch (_that) {
case _SelectedSubjectSubjectsEntity():
return $default(_that.subjectName,_that.semester);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? subjectName,  String? semester)?  $default,) {final _that = this;
switch (_that) {
case _SelectedSubjectSubjectsEntity() when $default != null:
return $default(_that.subjectName,_that.semester);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectedSubjectSubjectsEntity implements SelectedSubjectSubjectsEntity {
  const _SelectedSubjectSubjectsEntity({this.subjectName, this.semester});
  factory _SelectedSubjectSubjectsEntity.fromJson(Map<String, dynamic> json) => _$SelectedSubjectSubjectsEntityFromJson(json);

@override final  String? subjectName;
@override final  String? semester;

/// Create a copy of SelectedSubjectSubjectsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedSubjectSubjectsEntityCopyWith<_SelectedSubjectSubjectsEntity> get copyWith => __$SelectedSubjectSubjectsEntityCopyWithImpl<_SelectedSubjectSubjectsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectedSubjectSubjectsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedSubjectSubjectsEntity&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.semester, semester) || other.semester == semester));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,subjectName,semester);
}

@override
String toString() {
    return 'SelectedSubjectSubjectsEntity(subjectName: $subjectName, semester: $semester)';
}


}

/// @nodoc
abstract mixin class _$SelectedSubjectSubjectsEntityCopyWith<$Res> implements $SelectedSubjectSubjectsEntityCopyWith<$Res> {
  factory _$SelectedSubjectSubjectsEntityCopyWith(_SelectedSubjectSubjectsEntity value, $Res Function(_SelectedSubjectSubjectsEntity) _then) = __$SelectedSubjectSubjectsEntityCopyWithImpl;
@override @useResult
$Res call({
 String? subjectName, String? semester
});




}
/// @nodoc
class __$SelectedSubjectSubjectsEntityCopyWithImpl<$Res>
    implements _$SelectedSubjectSubjectsEntityCopyWith<$Res> {
  __$SelectedSubjectSubjectsEntityCopyWithImpl(this._self, this._then);

  final _SelectedSubjectSubjectsEntity _self;
  final $Res Function(_SelectedSubjectSubjectsEntity) _then;

/// Create a copy of SelectedSubjectSubjectsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subjectName = freezed,Object? semester = freezed,}) {
  return _then(_SelectedSubjectSubjectsEntity(
subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
