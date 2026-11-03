// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassEntity {

 String? get id; String? get subjectName; String? get subjectClass; String? get day; String? get lecturer; String? get sessionTime; String? get room;
/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassEntityCopyWith<ClassEntity> get copyWith => _$ClassEntityCopyWithImpl<ClassEntity>(this as ClassEntity, _$identity);

  /// Serializes this ClassEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ClassEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.subjectClass, _this.subjectClass) || other.subjectClass == _this.subjectClass)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.lecturer, _this.lecturer) || other.lecturer == _this.lecturer)&&(identical(other.sessionTime, _this.sessionTime) || other.sessionTime == _this.sessionTime)&&(identical(other.room, _this.room) || other.room == _this.room));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ClassEntity;
  return Object.hash(runtimeType,_this.id,_this.subjectName,_this.subjectClass,_this.day,_this.lecturer,_this.sessionTime,_this.room);
}

@override
String toString() {
  final _this = this as ClassEntity;
  return 'ClassEntity(id: ${_this.id}, subjectName: ${_this.subjectName}, subjectClass: ${_this.subjectClass}, day: ${_this.day}, lecturer: ${_this.lecturer}, sessionTime: ${_this.sessionTime}, room: ${_this.room})';
}


}

/// @nodoc
abstract mixin class $ClassEntityCopyWith<$Res>  {
  factory $ClassEntityCopyWith(ClassEntity value, $Res Function(ClassEntity) _then) = _$ClassEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? subjectName, String? subjectClass, String? day, String? lecturer, String? sessionTime, String? room
});




}
/// @nodoc
class _$ClassEntityCopyWithImpl<$Res>
    implements $ClassEntityCopyWith<$Res> {
  _$ClassEntityCopyWithImpl(this._self, this._then);

  final ClassEntity _self;
  final $Res Function(ClassEntity) _then;

/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? subjectName = freezed,Object? subjectClass = freezed,Object? day = freezed,Object? lecturer = freezed,Object? sessionTime = freezed,Object? room = freezed,}) {
  return _then(ClassEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,subjectClass: freezed == subjectClass ? _self.subjectClass : subjectClass // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,lecturer: freezed == lecturer ? _self.lecturer : lecturer // ignore: cast_nullable_to_non_nullable
as String?,sessionTime: freezed == sessionTime ? _self.sessionTime : sessionTime // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClassEntity].
extension ClassEntityPatterns on ClassEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassEntity value)  $default,){
final _that = this;
switch (_that) {
case _ClassEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ClassEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? subjectName,  String? subjectClass,  String? day,  String? lecturer,  String? sessionTime,  String? room)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassEntity() when $default != null:
return $default(_that.id,_that.subjectName,_that.subjectClass,_that.day,_that.lecturer,_that.sessionTime,_that.room);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? subjectName,  String? subjectClass,  String? day,  String? lecturer,  String? sessionTime,  String? room)  $default,) {final _that = this;
switch (_that) {
case _ClassEntity():
return $default(_that.id,_that.subjectName,_that.subjectClass,_that.day,_that.lecturer,_that.sessionTime,_that.room);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? subjectName,  String? subjectClass,  String? day,  String? lecturer,  String? sessionTime,  String? room)?  $default,) {final _that = this;
switch (_that) {
case _ClassEntity() when $default != null:
return $default(_that.id,_that.subjectName,_that.subjectClass,_that.day,_that.lecturer,_that.sessionTime,_that.room);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassEntity implements ClassEntity {
  const _ClassEntity({this.id, this.subjectName, this.subjectClass, this.day, this.lecturer, this.sessionTime, this.room});
  factory _ClassEntity.fromJson(Map<String, dynamic> json) => _$ClassEntityFromJson(json);

@override final  String? id;
@override final  String? subjectName;
@override final  String? subjectClass;
@override final  String? day;
@override final  String? lecturer;
@override final  String? sessionTime;
@override final  String? room;

/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassEntityCopyWith<_ClassEntity> get copyWith => __$ClassEntityCopyWithImpl<_ClassEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.subjectClass, subjectClass) || other.subjectClass == subjectClass)&&(identical(other.day, day) || other.day == day)&&(identical(other.lecturer, lecturer) || other.lecturer == lecturer)&&(identical(other.sessionTime, sessionTime) || other.sessionTime == sessionTime)&&(identical(other.room, room) || other.room == room));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,subjectName,subjectClass,day,lecturer,sessionTime,room);
}

@override
String toString() {
    return 'ClassEntity(id: $id, subjectName: $subjectName, subjectClass: $subjectClass, day: $day, lecturer: $lecturer, sessionTime: $sessionTime, room: $room)';
}


}

/// @nodoc
abstract mixin class _$ClassEntityCopyWith<$Res> implements $ClassEntityCopyWith<$Res> {
  factory _$ClassEntityCopyWith(_ClassEntity value, $Res Function(_ClassEntity) _then) = __$ClassEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? subjectName, String? subjectClass, String? day, String? lecturer, String? sessionTime, String? room
});




}
/// @nodoc
class __$ClassEntityCopyWithImpl<$Res>
    implements _$ClassEntityCopyWith<$Res> {
  __$ClassEntityCopyWithImpl(this._self, this._then);

  final _ClassEntity _self;
  final $Res Function(_ClassEntity) _then;

/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? subjectName = freezed,Object? subjectClass = freezed,Object? day = freezed,Object? lecturer = freezed,Object? sessionTime = freezed,Object? room = freezed,}) {
  return _then(_ClassEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,subjectClass: freezed == subjectClass ? _self.subjectClass : subjectClass // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,lecturer: freezed == lecturer ? _self.lecturer : lecturer // ignore: cast_nullable_to_non_nullable
as String?,sessionTime: freezed == sessionTime ? _self.sessionTime : sessionTime // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
