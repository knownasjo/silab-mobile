// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_data_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginDataEntity {

 String? get accessToken; String? get refreshToken;
/// Create a copy of LoginDataEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginDataEntityCopyWith<LoginDataEntity> get copyWith => _$LoginDataEntityCopyWithImpl<LoginDataEntity>(this as LoginDataEntity, _$identity);

  /// Serializes this LoginDataEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LoginDataEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginDataEntity&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.refreshToken, _this.refreshToken) || other.refreshToken == _this.refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LoginDataEntity;
  return Object.hash(runtimeType,_this.accessToken,_this.refreshToken);
}

@override
String toString() {
  final _this = this as LoginDataEntity;
  return 'LoginDataEntity(accessToken: ${_this.accessToken}, refreshToken: ${_this.refreshToken})';
}


}

/// @nodoc
abstract mixin class $LoginDataEntityCopyWith<$Res>  {
  factory $LoginDataEntityCopyWith(LoginDataEntity value, $Res Function(LoginDataEntity) _then) = _$LoginDataEntityCopyWithImpl;
@useResult
$Res call({
 String? accessToken, String? refreshToken
});




}
/// @nodoc
class _$LoginDataEntityCopyWithImpl<$Res>
    implements $LoginDataEntityCopyWith<$Res> {
  _$LoginDataEntityCopyWithImpl(this._self, this._then);

  final LoginDataEntity _self;
  final $Res Function(LoginDataEntity) _then;

/// Create a copy of LoginDataEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,}) {
  return _then(LoginDataEntity(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginDataEntity].
extension LoginDataEntityPatterns on LoginDataEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginDataEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginDataEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginDataEntity value)  $default,){
final _that = this;
switch (_that) {
case _LoginDataEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginDataEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LoginDataEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? accessToken,  String? refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginDataEntity() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? accessToken,  String? refreshToken)  $default,) {final _that = this;
switch (_that) {
case _LoginDataEntity():
return $default(_that.accessToken,_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? accessToken,  String? refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _LoginDataEntity() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginDataEntity implements LoginDataEntity {
  const _LoginDataEntity({this.accessToken, this.refreshToken});
  factory _LoginDataEntity.fromJson(Map<String, dynamic> json) => _$LoginDataEntityFromJson(json);

@override final  String? accessToken;
@override final  String? refreshToken;

/// Create a copy of LoginDataEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginDataEntityCopyWith<_LoginDataEntity> get copyWith => __$LoginDataEntityCopyWithImpl<_LoginDataEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginDataEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginDataEntity&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accessToken,refreshToken);
}

@override
String toString() {
    return 'LoginDataEntity(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$LoginDataEntityCopyWith<$Res> implements $LoginDataEntityCopyWith<$Res> {
  factory _$LoginDataEntityCopyWith(_LoginDataEntity value, $Res Function(_LoginDataEntity) _then) = __$LoginDataEntityCopyWithImpl;
@override @useResult
$Res call({
 String? accessToken, String? refreshToken
});




}
/// @nodoc
class __$LoginDataEntityCopyWithImpl<$Res>
    implements _$LoginDataEntityCopyWith<$Res> {
  __$LoginDataEntityCopyWithImpl(this._self, this._then);

  final _LoginDataEntity _self;
  final $Res Function(_LoginDataEntity) _then;

/// Create a copy of LoginDataEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,}) {
  return _then(_LoginDataEntity(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
