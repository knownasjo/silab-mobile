// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_class_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectedClassEntity {

 String? get subjectName; String? get className;
/// Create a copy of SelectedClassEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedClassEntityCopyWith<SelectedClassEntity> get copyWith => _$SelectedClassEntityCopyWithImpl<SelectedClassEntity>(this as SelectedClassEntity, _$identity);

  /// Serializes this SelectedClassEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SelectedClassEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedClassEntity&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.className, _this.className) || other.className == _this.className));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SelectedClassEntity;
  return Object.hash(runtimeType,_this.subjectName,_this.className);
}

@override
String toString() {
  final _this = this as SelectedClassEntity;
  return 'SelectedClassEntity(subjectName: ${_this.subjectName}, className: ${_this.className})';
}


}

/// @nodoc
abstract mixin class $SelectedClassEntityCopyWith<$Res>  {
  factory $SelectedClassEntityCopyWith(SelectedClassEntity value, $Res Function(SelectedClassEntity) _then) = _$SelectedClassEntityCopyWithImpl;
@useResult
$Res call({
 String? subjectName, String? className
});




}
/// @nodoc
class _$SelectedClassEntityCopyWithImpl<$Res>
    implements $SelectedClassEntityCopyWith<$Res> {
  _$SelectedClassEntityCopyWithImpl(this._self, this._then);

  final SelectedClassEntity _self;
  final $Res Function(SelectedClassEntity) _then;

/// Create a copy of SelectedClassEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subjectName = freezed,Object? className = freezed,}) {
  return _then(SelectedClassEntity(
subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,className: freezed == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectedClassEntity].
extension SelectedClassEntityPatterns on SelectedClassEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectedClassEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectedClassEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectedClassEntity value)  $default,){
final _that = this;
switch (_that) {
case _SelectedClassEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectedClassEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SelectedClassEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? subjectName,  String? className)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectedClassEntity() when $default != null:
return $default(_that.subjectName,_that.className);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? subjectName,  String? className)  $default,) {final _that = this;
switch (_that) {
case _SelectedClassEntity():
return $default(_that.subjectName,_that.className);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? subjectName,  String? className)?  $default,) {final _that = this;
switch (_that) {
case _SelectedClassEntity() when $default != null:
return $default(_that.subjectName,_that.className);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectedClassEntity implements SelectedClassEntity {
  const _SelectedClassEntity({this.subjectName, this.className});
  factory _SelectedClassEntity.fromJson(Map<String, dynamic> json) => _$SelectedClassEntityFromJson(json);

@override final  String? subjectName;
@override final  String? className;

/// Create a copy of SelectedClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedClassEntityCopyWith<_SelectedClassEntity> get copyWith => __$SelectedClassEntityCopyWithImpl<_SelectedClassEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectedClassEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedClassEntity&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.className, className) || other.className == className));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,subjectName,className);
}

@override
String toString() {
    return 'SelectedClassEntity(subjectName: $subjectName, className: $className)';
}


}

/// @nodoc
abstract mixin class _$SelectedClassEntityCopyWith<$Res> implements $SelectedClassEntityCopyWith<$Res> {
  factory _$SelectedClassEntityCopyWith(_SelectedClassEntity value, $Res Function(_SelectedClassEntity) _then) = __$SelectedClassEntityCopyWithImpl;
@override @useResult
$Res call({
 String? subjectName, String? className
});




}
/// @nodoc
class __$SelectedClassEntityCopyWithImpl<$Res>
    implements _$SelectedClassEntityCopyWith<$Res> {
  __$SelectedClassEntityCopyWithImpl(this._self, this._then);

  final _SelectedClassEntity _self;
  final $Res Function(_SelectedClassEntity) _then;

/// Create a copy of SelectedClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subjectName = freezed,Object? className = freezed,}) {
  return _then(_SelectedClassEntity(
subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,className: freezed == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
