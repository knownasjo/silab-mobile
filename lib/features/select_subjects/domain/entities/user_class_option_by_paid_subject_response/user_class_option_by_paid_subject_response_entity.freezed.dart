// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_class_option_by_paid_subject_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserClassOptionByPaidSubjectResponseEntity {

 bool? get status; String? get message; List<UserClassOptionByPaidSubjectEntity>? get data;
/// Create a copy of UserClassOptionByPaidSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserClassOptionByPaidSubjectResponseEntityCopyWith<UserClassOptionByPaidSubjectResponseEntity> get copyWith => _$UserClassOptionByPaidSubjectResponseEntityCopyWithImpl<UserClassOptionByPaidSubjectResponseEntity>(this as UserClassOptionByPaidSubjectResponseEntity, _$identity);

  /// Serializes this UserClassOptionByPaidSubjectResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserClassOptionByPaidSubjectResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserClassOptionByPaidSubjectResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.data, _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserClassOptionByPaidSubjectResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,const DeepCollectionEquality().hash(_this.data));
}

@override
String toString() {
  final _this = this as UserClassOptionByPaidSubjectResponseEntity;
  return 'UserClassOptionByPaidSubjectResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $UserClassOptionByPaidSubjectResponseEntityCopyWith<$Res>  {
  factory $UserClassOptionByPaidSubjectResponseEntityCopyWith(UserClassOptionByPaidSubjectResponseEntity value, $Res Function(UserClassOptionByPaidSubjectResponseEntity) _then) = _$UserClassOptionByPaidSubjectResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message, List<UserClassOptionByPaidSubjectEntity>? data
});




}
/// @nodoc
class _$UserClassOptionByPaidSubjectResponseEntityCopyWithImpl<$Res>
    implements $UserClassOptionByPaidSubjectResponseEntityCopyWith<$Res> {
  _$UserClassOptionByPaidSubjectResponseEntityCopyWithImpl(this._self, this._then);

  final UserClassOptionByPaidSubjectResponseEntity _self;
  final $Res Function(UserClassOptionByPaidSubjectResponseEntity) _then;

/// Create a copy of UserClassOptionByPaidSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(UserClassOptionByPaidSubjectResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<UserClassOptionByPaidSubjectEntity>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserClassOptionByPaidSubjectResponseEntity].
extension UserClassOptionByPaidSubjectResponseEntityPatterns on UserClassOptionByPaidSubjectResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserClassOptionByPaidSubjectResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserClassOptionByPaidSubjectResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserClassOptionByPaidSubjectResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? status,  String? message,  List<UserClassOptionByPaidSubjectEntity>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? status,  String? message,  List<UserClassOptionByPaidSubjectEntity>? data)  $default,) {final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectResponseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? status,  String? message,  List<UserClassOptionByPaidSubjectEntity>? data)?  $default,) {final _that = this;
switch (_that) {
case _UserClassOptionByPaidSubjectResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserClassOptionByPaidSubjectResponseEntity implements UserClassOptionByPaidSubjectResponseEntity {
  const _UserClassOptionByPaidSubjectResponseEntity({this.status, this.message,  List<UserClassOptionByPaidSubjectEntity>? data}): _data = data;
  factory _UserClassOptionByPaidSubjectResponseEntity.fromJson(Map<String, dynamic> json) => _$UserClassOptionByPaidSubjectResponseEntityFromJson(json);

@override final  bool? status;
@override final  String? message;
 final  List<UserClassOptionByPaidSubjectEntity>? _data;
@override List<UserClassOptionByPaidSubjectEntity>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UserClassOptionByPaidSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserClassOptionByPaidSubjectResponseEntityCopyWith<_UserClassOptionByPaidSubjectResponseEntity> get copyWith => __$UserClassOptionByPaidSubjectResponseEntityCopyWithImpl<_UserClassOptionByPaidSubjectResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserClassOptionByPaidSubjectResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserClassOptionByPaidSubjectResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(_data));
}

@override
String toString() {
    return 'UserClassOptionByPaidSubjectResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$UserClassOptionByPaidSubjectResponseEntityCopyWith<$Res> implements $UserClassOptionByPaidSubjectResponseEntityCopyWith<$Res> {
  factory _$UserClassOptionByPaidSubjectResponseEntityCopyWith(_UserClassOptionByPaidSubjectResponseEntity value, $Res Function(_UserClassOptionByPaidSubjectResponseEntity) _then) = __$UserClassOptionByPaidSubjectResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message, List<UserClassOptionByPaidSubjectEntity>? data
});




}
/// @nodoc
class __$UserClassOptionByPaidSubjectResponseEntityCopyWithImpl<$Res>
    implements _$UserClassOptionByPaidSubjectResponseEntityCopyWith<$Res> {
  __$UserClassOptionByPaidSubjectResponseEntityCopyWithImpl(this._self, this._then);

  final _UserClassOptionByPaidSubjectResponseEntity _self;
  final $Res Function(_UserClassOptionByPaidSubjectResponseEntity) _then;

/// Create a copy of UserClassOptionByPaidSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_UserClassOptionByPaidSubjectResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<UserClassOptionByPaidSubjectEntity>?,
  ));
}


}

// dart format on
