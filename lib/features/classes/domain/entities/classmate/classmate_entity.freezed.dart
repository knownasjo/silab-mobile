// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classmate_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassmateEntity {

 String? get name; bool? get isMe;
/// Create a copy of ClassmateEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassmateEntityCopyWith<ClassmateEntity> get copyWith => _$ClassmateEntityCopyWithImpl<ClassmateEntity>(this as ClassmateEntity, _$identity);

  /// Serializes this ClassmateEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ClassmateEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassmateEntity&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.isMe, _this.isMe) || other.isMe == _this.isMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ClassmateEntity;
  return Object.hash(runtimeType,_this.name,_this.isMe);
}

@override
String toString() {
  final _this = this as ClassmateEntity;
  return 'ClassmateEntity(name: ${_this.name}, isMe: ${_this.isMe})';
}


}

/// @nodoc
abstract mixin class $ClassmateEntityCopyWith<$Res>  {
  factory $ClassmateEntityCopyWith(ClassmateEntity value, $Res Function(ClassmateEntity) _then) = _$ClassmateEntityCopyWithImpl;
@useResult
$Res call({
 String? name, bool? isMe
});




}
/// @nodoc
class _$ClassmateEntityCopyWithImpl<$Res>
    implements $ClassmateEntityCopyWith<$Res> {
  _$ClassmateEntityCopyWithImpl(this._self, this._then);

  final ClassmateEntity _self;
  final $Res Function(ClassmateEntity) _then;

/// Create a copy of ClassmateEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? isMe = freezed,}) {
  return _then(ClassmateEntity(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,isMe: freezed == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClassmateEntity].
extension ClassmateEntityPatterns on ClassmateEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassmateEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassmateEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassmateEntity value)  $default,){
final _that = this;
switch (_that) {
case _ClassmateEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassmateEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ClassmateEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  bool? isMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassmateEntity() when $default != null:
return $default(_that.name,_that.isMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  bool? isMe)  $default,) {final _that = this;
switch (_that) {
case _ClassmateEntity():
return $default(_that.name,_that.isMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  bool? isMe)?  $default,) {final _that = this;
switch (_that) {
case _ClassmateEntity() when $default != null:
return $default(_that.name,_that.isMe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassmateEntity implements ClassmateEntity {
  const _ClassmateEntity({this.name, this.isMe});
  factory _ClassmateEntity.fromJson(Map<String, dynamic> json) => _$ClassmateEntityFromJson(json);

@override final  String? name;
@override final  bool? isMe;

/// Create a copy of ClassmateEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassmateEntityCopyWith<_ClassmateEntity> get copyWith => __$ClassmateEntityCopyWithImpl<_ClassmateEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassmateEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassmateEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.isMe, isMe) || other.isMe == isMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,isMe);
}

@override
String toString() {
    return 'ClassmateEntity(name: $name, isMe: $isMe)';
}


}

/// @nodoc
abstract mixin class _$ClassmateEntityCopyWith<$Res> implements $ClassmateEntityCopyWith<$Res> {
  factory _$ClassmateEntityCopyWith(_ClassmateEntity value, $Res Function(_ClassmateEntity) _then) = __$ClassmateEntityCopyWithImpl;
@override @useResult
$Res call({
 String? name, bool? isMe
});




}
/// @nodoc
class __$ClassmateEntityCopyWithImpl<$Res>
    implements _$ClassmateEntityCopyWith<$Res> {
  __$ClassmateEntityCopyWithImpl(this._self, this._then);

  final _ClassmateEntity _self;
  final $Res Function(_ClassmateEntity) _then;

/// Create a copy of ClassmateEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? isMe = freezed,}) {
  return _then(_ClassmateEntity(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,isMe: freezed == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
