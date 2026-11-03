// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_selected_class_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddSelectedClassResponseEntity {

 bool? get status; String? get message;
/// Create a copy of AddSelectedClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddSelectedClassResponseEntityCopyWith<AddSelectedClassResponseEntity> get copyWith => _$AddSelectedClassResponseEntityCopyWithImpl<AddSelectedClassResponseEntity>(this as AddSelectedClassResponseEntity, _$identity);

  /// Serializes this AddSelectedClassResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddSelectedClassResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddSelectedClassResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddSelectedClassResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message);
}

@override
String toString() {
  final _this = this as AddSelectedClassResponseEntity;
  return 'AddSelectedClassResponseEntity(status: ${_this.status}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $AddSelectedClassResponseEntityCopyWith<$Res>  {
  factory $AddSelectedClassResponseEntityCopyWith(AddSelectedClassResponseEntity value, $Res Function(AddSelectedClassResponseEntity) _then) = _$AddSelectedClassResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message
});




}
/// @nodoc
class _$AddSelectedClassResponseEntityCopyWithImpl<$Res>
    implements $AddSelectedClassResponseEntityCopyWith<$Res> {
  _$AddSelectedClassResponseEntityCopyWithImpl(this._self, this._then);

  final AddSelectedClassResponseEntity _self;
  final $Res Function(AddSelectedClassResponseEntity) _then;

/// Create a copy of AddSelectedClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,}) {
  return _then(AddSelectedClassResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddSelectedClassResponseEntity].
extension AddSelectedClassResponseEntityPatterns on AddSelectedClassResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddSelectedClassResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddSelectedClassResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddSelectedClassResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _AddSelectedClassResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddSelectedClassResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AddSelectedClassResponseEntity() when $default != null:
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
case _AddSelectedClassResponseEntity() when $default != null:
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
case _AddSelectedClassResponseEntity():
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
case _AddSelectedClassResponseEntity() when $default != null:
return $default(_that.status,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddSelectedClassResponseEntity implements AddSelectedClassResponseEntity {
  const _AddSelectedClassResponseEntity({this.status, this.message});
  factory _AddSelectedClassResponseEntity.fromJson(Map<String, dynamic> json) => _$AddSelectedClassResponseEntityFromJson(json);

@override final  bool? status;
@override final  String? message;

/// Create a copy of AddSelectedClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddSelectedClassResponseEntityCopyWith<_AddSelectedClassResponseEntity> get copyWith => __$AddSelectedClassResponseEntityCopyWithImpl<_AddSelectedClassResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddSelectedClassResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddSelectedClassResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message);
}

@override
String toString() {
    return 'AddSelectedClassResponseEntity(status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AddSelectedClassResponseEntityCopyWith<$Res> implements $AddSelectedClassResponseEntityCopyWith<$Res> {
  factory _$AddSelectedClassResponseEntityCopyWith(_AddSelectedClassResponseEntity value, $Res Function(_AddSelectedClassResponseEntity) _then) = __$AddSelectedClassResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message
});




}
/// @nodoc
class __$AddSelectedClassResponseEntityCopyWithImpl<$Res>
    implements _$AddSelectedClassResponseEntityCopyWith<$Res> {
  __$AddSelectedClassResponseEntityCopyWithImpl(this._self, this._then);

  final _AddSelectedClassResponseEntity _self;
  final $Res Function(_AddSelectedClassResponseEntity) _then;

/// Create a copy of AddSelectedClassResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,}) {
  return _then(_AddSelectedClassResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
