// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDetailEntity {

 String? get nim;@JsonKey(name: 'name') String? get fullname; String? get email;
/// Create a copy of UserDetailEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDetailEntityCopyWith<UserDetailEntity> get copyWith => _$UserDetailEntityCopyWithImpl<UserDetailEntity>(this as UserDetailEntity, _$identity);

  /// Serializes this UserDetailEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserDetailEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDetailEntity&&(identical(other.nim, _this.nim) || other.nim == _this.nim)&&(identical(other.fullname, _this.fullname) || other.fullname == _this.fullname)&&(identical(other.email, _this.email) || other.email == _this.email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserDetailEntity;
  return Object.hash(runtimeType,_this.nim,_this.fullname,_this.email);
}

@override
String toString() {
  final _this = this as UserDetailEntity;
  return 'UserDetailEntity(nim: ${_this.nim}, fullname: ${_this.fullname}, email: ${_this.email})';
}


}

/// @nodoc
abstract mixin class $UserDetailEntityCopyWith<$Res>  {
  factory $UserDetailEntityCopyWith(UserDetailEntity value, $Res Function(UserDetailEntity) _then) = _$UserDetailEntityCopyWithImpl;
@useResult
$Res call({
 String? nim,@JsonKey(name: 'name') String? fullname, String? email
});




}
/// @nodoc
class _$UserDetailEntityCopyWithImpl<$Res>
    implements $UserDetailEntityCopyWith<$Res> {
  _$UserDetailEntityCopyWithImpl(this._self, this._then);

  final UserDetailEntity _self;
  final $Res Function(UserDetailEntity) _then;

/// Create a copy of UserDetailEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nim = freezed,Object? fullname = freezed,Object? email = freezed,}) {
  return _then(UserDetailEntity(
nim: freezed == nim ? _self.nim : nim // ignore: cast_nullable_to_non_nullable
as String?,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserDetailEntity].
extension UserDetailEntityPatterns on UserDetailEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDetailEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDetailEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDetailEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserDetailEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDetailEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserDetailEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nim, @JsonKey(name: 'name')  String? fullname,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDetailEntity() when $default != null:
return $default(_that.nim,_that.fullname,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nim, @JsonKey(name: 'name')  String? fullname,  String? email)  $default,) {final _that = this;
switch (_that) {
case _UserDetailEntity():
return $default(_that.nim,_that.fullname,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nim, @JsonKey(name: 'name')  String? fullname,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _UserDetailEntity() when $default != null:
return $default(_that.nim,_that.fullname,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserDetailEntity implements UserDetailEntity {
  const _UserDetailEntity({this.nim, @JsonKey(name: 'name') this.fullname, this.email});
  factory _UserDetailEntity.fromJson(Map<String, dynamic> json) => _$UserDetailEntityFromJson(json);

@override final  String? nim;
@override@JsonKey(name: 'name') final  String? fullname;
@override final  String? email;

/// Create a copy of UserDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDetailEntityCopyWith<_UserDetailEntity> get copyWith => __$UserDetailEntityCopyWithImpl<_UserDetailEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDetailEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDetailEntity&&(identical(other.nim, nim) || other.nim == nim)&&(identical(other.fullname, fullname) || other.fullname == fullname)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,nim,fullname,email);
}

@override
String toString() {
    return 'UserDetailEntity(nim: $nim, fullname: $fullname, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserDetailEntityCopyWith<$Res> implements $UserDetailEntityCopyWith<$Res> {
  factory _$UserDetailEntityCopyWith(_UserDetailEntity value, $Res Function(_UserDetailEntity) _then) = __$UserDetailEntityCopyWithImpl;
@override @useResult
$Res call({
 String? nim,@JsonKey(name: 'name') String? fullname, String? email
});




}
/// @nodoc
class __$UserDetailEntityCopyWithImpl<$Res>
    implements _$UserDetailEntityCopyWith<$Res> {
  __$UserDetailEntityCopyWithImpl(this._self, this._then);

  final _UserDetailEntity _self;
  final $Res Function(_UserDetailEntity) _then;

/// Create a copy of UserDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nim = freezed,Object? fullname = freezed,Object? email = freezed,}) {
  return _then(_UserDetailEntity(
nim: freezed == nim ? _self.nim : nim // ignore: cast_nullable_to_non_nullable
as String?,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
