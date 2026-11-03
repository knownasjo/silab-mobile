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

 String? get id; String? get name; String? get lecturer; int? get semester; List<String>? get classes;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.lecturer, _this.lecturer) || other.lecturer == _this.lecturer)&&(identical(other.semester, _this.semester) || other.semester == _this.semester)&&const DeepCollectionEquality().equals(other.classes, _this.classes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubjectEntity;
  return Object.hash(runtimeType,_this.id,_this.name,_this.lecturer,_this.semester,const DeepCollectionEquality().hash(_this.classes));
}

@override
String toString() {
  final _this = this as SubjectEntity;
  return 'SubjectEntity(id: ${_this.id}, name: ${_this.name}, lecturer: ${_this.lecturer}, semester: ${_this.semester}, classes: ${_this.classes})';
}


}

/// @nodoc
abstract mixin class $SubjectEntityCopyWith<$Res>  {
  factory $SubjectEntityCopyWith(SubjectEntity value, $Res Function(SubjectEntity) _then) = _$SubjectEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? lecturer, int? semester, List<String>? classes
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? lecturer = freezed,Object? semester = freezed,Object? classes = freezed,}) {
  return _then(SubjectEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,lecturer: freezed == lecturer ? _self.lecturer : lecturer // ignore: cast_nullable_to_non_nullable
as String?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as int?,classes: freezed == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<String>?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name,  String? lecturer,  int? semester,  List<String>? classes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectEntity() when $default != null:
return $default(_that.id,_that.name,_that.lecturer,_that.semester,_that.classes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name,  String? lecturer,  int? semester,  List<String>? classes)  $default,) {final _that = this;
switch (_that) {
case _SubjectEntity():
return $default(_that.id,_that.name,_that.lecturer,_that.semester,_that.classes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name,  String? lecturer,  int? semester,  List<String>? classes)?  $default,) {final _that = this;
switch (_that) {
case _SubjectEntity() when $default != null:
return $default(_that.id,_that.name,_that.lecturer,_that.semester,_that.classes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubjectEntity implements SubjectEntity {
  const _SubjectEntity({this.id, this.name, this.lecturer, this.semester,  List<String>? classes}): _classes = classes;
  factory _SubjectEntity.fromJson(Map<String, dynamic> json) => _$SubjectEntityFromJson(json);

@override final  String? id;
@override final  String? name;
@override final  String? lecturer;
@override final  int? semester;
 final  List<String>? _classes;
@override List<String>? get classes {
  final value = _classes;
  if (value == null) return null;
  if (_classes is EqualUnmodifiableListView) return _classes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lecturer, lecturer) || other.lecturer == lecturer)&&(identical(other.semester, semester) || other.semester == semester)&&const DeepCollectionEquality().equals(other.classes, _classes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,lecturer,semester,const DeepCollectionEquality().hash(_classes));
}

@override
String toString() {
    return 'SubjectEntity(id: $id, name: $name, lecturer: $lecturer, semester: $semester, classes: $classes)';
}


}

/// @nodoc
abstract mixin class _$SubjectEntityCopyWith<$Res> implements $SubjectEntityCopyWith<$Res> {
  factory _$SubjectEntityCopyWith(_SubjectEntity value, $Res Function(_SubjectEntity) _then) = __$SubjectEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? lecturer, int? semester, List<String>? classes
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? lecturer = freezed,Object? semester = freezed,Object? classes = freezed,}) {
  return _then(_SubjectEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,lecturer: freezed == lecturer ? _self.lecturer : lecturer // ignore: cast_nullable_to_non_nullable
as String?,semester: freezed == semester ? _self.semester : semester // ignore: cast_nullable_to_non_nullable
as int?,classes: freezed == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
