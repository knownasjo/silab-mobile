// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activation_class_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivationClassEntity {

 String? get id; String? get name; String? get day; String? get sessionTime;
/// Create a copy of ActivationClassEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivationClassEntityCopyWith<ActivationClassEntity> get copyWith => _$ActivationClassEntityCopyWithImpl<ActivationClassEntity>(this as ActivationClassEntity, _$identity);

  /// Serializes this ActivationClassEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivationClassEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivationClassEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.sessionTime, _this.sessionTime) || other.sessionTime == _this.sessionTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivationClassEntity;
  return Object.hash(runtimeType,_this.id,_this.name,_this.day,_this.sessionTime);
}

@override
String toString() {
  final _this = this as ActivationClassEntity;
  return 'ActivationClassEntity(id: ${_this.id}, name: ${_this.name}, day: ${_this.day}, sessionTime: ${_this.sessionTime})';
}


}

/// @nodoc
abstract mixin class $ActivationClassEntityCopyWith<$Res>  {
  factory $ActivationClassEntityCopyWith(ActivationClassEntity value, $Res Function(ActivationClassEntity) _then) = _$ActivationClassEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? day, String? sessionTime
});




}
/// @nodoc
class _$ActivationClassEntityCopyWithImpl<$Res>
    implements $ActivationClassEntityCopyWith<$Res> {
  _$ActivationClassEntityCopyWithImpl(this._self, this._then);

  final ActivationClassEntity _self;
  final $Res Function(ActivationClassEntity) _then;

/// Create a copy of ActivationClassEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? day = freezed,Object? sessionTime = freezed,}) {
  return _then(ActivationClassEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,sessionTime: freezed == sessionTime ? _self.sessionTime : sessionTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivationClassEntity].
extension ActivationClassEntityPatterns on ActivationClassEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivationClassEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivationClassEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivationClassEntity value)  $default,){
final _that = this;
switch (_that) {
case _ActivationClassEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivationClassEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ActivationClassEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name,  String? day,  String? sessionTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivationClassEntity() when $default != null:
return $default(_that.id,_that.name,_that.day,_that.sessionTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name,  String? day,  String? sessionTime)  $default,) {final _that = this;
switch (_that) {
case _ActivationClassEntity():
return $default(_that.id,_that.name,_that.day,_that.sessionTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name,  String? day,  String? sessionTime)?  $default,) {final _that = this;
switch (_that) {
case _ActivationClassEntity() when $default != null:
return $default(_that.id,_that.name,_that.day,_that.sessionTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivationClassEntity implements ActivationClassEntity {
  const _ActivationClassEntity({this.id, this.name, this.day, this.sessionTime});
  factory _ActivationClassEntity.fromJson(Map<String, dynamic> json) => _$ActivationClassEntityFromJson(json);

@override final  String? id;
@override final  String? name;
@override final  String? day;
@override final  String? sessionTime;

/// Create a copy of ActivationClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivationClassEntityCopyWith<_ActivationClassEntity> get copyWith => __$ActivationClassEntityCopyWithImpl<_ActivationClassEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivationClassEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivationClassEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.day, day) || other.day == day)&&(identical(other.sessionTime, sessionTime) || other.sessionTime == sessionTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,day,sessionTime);
}

@override
String toString() {
    return 'ActivationClassEntity(id: $id, name: $name, day: $day, sessionTime: $sessionTime)';
}


}

/// @nodoc
abstract mixin class _$ActivationClassEntityCopyWith<$Res> implements $ActivationClassEntityCopyWith<$Res> {
  factory _$ActivationClassEntityCopyWith(_ActivationClassEntity value, $Res Function(_ActivationClassEntity) _then) = __$ActivationClassEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? day, String? sessionTime
});




}
/// @nodoc
class __$ActivationClassEntityCopyWithImpl<$Res>
    implements _$ActivationClassEntityCopyWith<$Res> {
  __$ActivationClassEntityCopyWithImpl(this._self, this._then);

  final _ActivationClassEntity _self;
  final $Res Function(_ActivationClassEntity) _then;

/// Create a copy of ActivationClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? day = freezed,Object? sessionTime = freezed,}) {
  return _then(_ActivationClassEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,sessionTime: freezed == sessionTime ? _self.sessionTime : sessionTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
