// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassResponseEntity {

 int? get status; String? get message; ClassEntity? get data;
/// Create a copy of ClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassResponseEntityCopyWith<ClassResponseEntity> get copyWith => _$ClassResponseEntityCopyWithImpl<ClassResponseEntity>(this as ClassResponseEntity, _$identity);

  /// Serializes this ClassResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ClassResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ClassResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as ClassResponseEntity;
  return 'ClassResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $ClassResponseEntityCopyWith<$Res>  {
  factory $ClassResponseEntityCopyWith(ClassResponseEntity value, $Res Function(ClassResponseEntity) _then) = _$ClassResponseEntityCopyWithImpl;
@useResult
$Res call({
 int? status, String? message, ClassEntity? data
});


$ClassEntityCopyWith<$Res>? get data;

}
/// @nodoc
class _$ClassResponseEntityCopyWithImpl<$Res>
    implements $ClassResponseEntityCopyWith<$Res> {
  _$ClassResponseEntityCopyWithImpl(this._self, this._then);

  final ClassResponseEntity _self;
  final $Res Function(ClassResponseEntity) _then;

/// Create a copy of ClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(ClassResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ClassEntity?,
  ));
}
/// Create a copy of ClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassEntityCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ClassEntityCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClassResponseEntity].
extension ClassResponseEntityPatterns on ClassResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _ClassResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ClassResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? status,  String? message,  ClassEntity? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? status,  String? message,  ClassEntity? data)  $default,) {final _that = this;
switch (_that) {
case _ClassResponseEntity():
return $default(_that.status,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? status,  String? message,  ClassEntity? data)?  $default,) {final _that = this;
switch (_that) {
case _ClassResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassResponseEntity implements ClassResponseEntity {
  const _ClassResponseEntity({this.status, this.message, this.data});
  factory _ClassResponseEntity.fromJson(Map<String, dynamic> json) => _$ClassResponseEntityFromJson(json);

@override final  int? status;
@override final  String? message;
@override final  ClassEntity? data;

/// Create a copy of ClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassResponseEntityCopyWith<_ClassResponseEntity> get copyWith => __$ClassResponseEntityCopyWithImpl<_ClassResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,data);
}

@override
String toString() {
    return 'ClassResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ClassResponseEntityCopyWith<$Res> implements $ClassResponseEntityCopyWith<$Res> {
  factory _$ClassResponseEntityCopyWith(_ClassResponseEntity value, $Res Function(_ClassResponseEntity) _then) = __$ClassResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 int? status, String? message, ClassEntity? data
});


@override $ClassEntityCopyWith<$Res>? get data;

}
/// @nodoc
class __$ClassResponseEntityCopyWithImpl<$Res>
    implements _$ClassResponseEntityCopyWith<$Res> {
  __$ClassResponseEntityCopyWithImpl(this._self, this._then);

  final _ClassResponseEntity _self;
  final $Res Function(_ClassResponseEntity) _then;

/// Create a copy of ClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_ClassResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ClassEntity?,
  ));
}

/// Create a copy of ClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassEntityCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ClassEntityCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
