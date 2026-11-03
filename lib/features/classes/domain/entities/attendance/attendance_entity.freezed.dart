// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceEntity {

 bool? get status; String? get message;
/// Create a copy of AttendanceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceEntityCopyWith<AttendanceEntity> get copyWith => _$AttendanceEntityCopyWithImpl<AttendanceEntity>(this as AttendanceEntity, _$identity);

  /// Serializes this AttendanceEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AttendanceEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AttendanceEntity;
  return Object.hash(runtimeType,_this.status,_this.message);
}

@override
String toString() {
  final _this = this as AttendanceEntity;
  return 'AttendanceEntity(status: ${_this.status}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $AttendanceEntityCopyWith<$Res>  {
  factory $AttendanceEntityCopyWith(AttendanceEntity value, $Res Function(AttendanceEntity) _then) = _$AttendanceEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message
});




}
/// @nodoc
class _$AttendanceEntityCopyWithImpl<$Res>
    implements $AttendanceEntityCopyWith<$Res> {
  _$AttendanceEntityCopyWithImpl(this._self, this._then);

  final AttendanceEntity _self;
  final $Res Function(AttendanceEntity) _then;

/// Create a copy of AttendanceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,}) {
  return _then(AttendanceEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceEntity].
extension AttendanceEntityPatterns on AttendanceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceEntity value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? status,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceEntity() when $default != null:
return $default(_that.status,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? status,  String? message)  $default,) {final _that = this;
switch (_that) {
case _AttendanceEntity():
return $default(_that.status,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? status,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceEntity() when $default != null:
return $default(_that.status,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceEntity implements AttendanceEntity {
  const _AttendanceEntity({this.status, this.message});
  factory _AttendanceEntity.fromJson(Map<String, dynamic> json) => _$AttendanceEntityFromJson(json);

@override final  bool? status;
@override final  String? message;

/// Create a copy of AttendanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceEntityCopyWith<_AttendanceEntity> get copyWith => __$AttendanceEntityCopyWithImpl<_AttendanceEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message);
}

@override
String toString() {
    return 'AttendanceEntity(status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AttendanceEntityCopyWith<$Res> implements $AttendanceEntityCopyWith<$Res> {
  factory _$AttendanceEntityCopyWith(_AttendanceEntity value, $Res Function(_AttendanceEntity) _then) = __$AttendanceEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message
});




}
/// @nodoc
class __$AttendanceEntityCopyWithImpl<$Res>
    implements _$AttendanceEntityCopyWith<$Res> {
  __$AttendanceEntityCopyWithImpl(this._self, this._then);

  final _AttendanceEntity _self;
  final $Res Function(_AttendanceEntity) _then;

/// Create a copy of AttendanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,}) {
  return _then(_AttendanceEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
