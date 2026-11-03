// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_subject_subjects_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddSubjectSubjectsEntity {

 String? get id;
/// Create a copy of AddSubjectSubjectsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddSubjectSubjectsEntityCopyWith<AddSubjectSubjectsEntity> get copyWith => _$AddSubjectSubjectsEntityCopyWithImpl<AddSubjectSubjectsEntity>(this as AddSubjectSubjectsEntity, _$identity);

  /// Serializes this AddSubjectSubjectsEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddSubjectSubjectsEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddSubjectSubjectsEntity&&(identical(other.id, _this.id) || other.id == _this.id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddSubjectSubjectsEntity;
  return Object.hash(runtimeType,_this.id);
}

@override
String toString() {
  final _this = this as AddSubjectSubjectsEntity;
  return 'AddSubjectSubjectsEntity(id: ${_this.id})';
}


}

/// @nodoc
abstract mixin class $AddSubjectSubjectsEntityCopyWith<$Res>  {
  factory $AddSubjectSubjectsEntityCopyWith(AddSubjectSubjectsEntity value, $Res Function(AddSubjectSubjectsEntity) _then) = _$AddSubjectSubjectsEntityCopyWithImpl;
@useResult
$Res call({
 String? id
});




}
/// @nodoc
class _$AddSubjectSubjectsEntityCopyWithImpl<$Res>
    implements $AddSubjectSubjectsEntityCopyWith<$Res> {
  _$AddSubjectSubjectsEntityCopyWithImpl(this._self, this._then);

  final AddSubjectSubjectsEntity _self;
  final $Res Function(AddSubjectSubjectsEntity) _then;

/// Create a copy of AddSubjectSubjectsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,}) {
  return _then(AddSubjectSubjectsEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddSubjectSubjectsEntity].
extension AddSubjectSubjectsEntityPatterns on AddSubjectSubjectsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddSubjectSubjectsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddSubjectSubjectsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddSubjectSubjectsEntity value)  $default,){
final _that = this;
switch (_that) {
case _AddSubjectSubjectsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddSubjectSubjectsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AddSubjectSubjectsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddSubjectSubjectsEntity() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id)  $default,) {final _that = this;
switch (_that) {
case _AddSubjectSubjectsEntity():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id)?  $default,) {final _that = this;
switch (_that) {
case _AddSubjectSubjectsEntity() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddSubjectSubjectsEntity implements AddSubjectSubjectsEntity {
  const _AddSubjectSubjectsEntity({this.id});
  factory _AddSubjectSubjectsEntity.fromJson(Map<String, dynamic> json) => _$AddSubjectSubjectsEntityFromJson(json);

@override final  String? id;

/// Create a copy of AddSubjectSubjectsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddSubjectSubjectsEntityCopyWith<_AddSubjectSubjectsEntity> get copyWith => __$AddSubjectSubjectsEntityCopyWithImpl<_AddSubjectSubjectsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddSubjectSubjectsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddSubjectSubjectsEntity&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'AddSubjectSubjectsEntity(id: $id)';
}


}

/// @nodoc
abstract mixin class _$AddSubjectSubjectsEntityCopyWith<$Res> implements $AddSubjectSubjectsEntityCopyWith<$Res> {
  factory _$AddSubjectSubjectsEntityCopyWith(_AddSubjectSubjectsEntity value, $Res Function(_AddSubjectSubjectsEntity) _then) = __$AddSubjectSubjectsEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id
});




}
/// @nodoc
class __$AddSubjectSubjectsEntityCopyWithImpl<$Res>
    implements _$AddSubjectSubjectsEntityCopyWith<$Res> {
  __$AddSubjectSubjectsEntityCopyWithImpl(this._self, this._then);

  final _AddSubjectSubjectsEntity _self;
  final $Res Function(_AddSubjectSubjectsEntity) _then;

/// Create a copy of AddSubjectSubjectsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,}) {
  return _then(_AddSubjectSubjectsEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
