// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classes_details_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassesDetailsResponseEntity {

 int? get status; String? get message; List<ClassEntity>? get data;
/// Create a copy of ClassesDetailsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassesDetailsResponseEntityCopyWith<ClassesDetailsResponseEntity> get copyWith => _$ClassesDetailsResponseEntityCopyWithImpl<ClassesDetailsResponseEntity>(this as ClassesDetailsResponseEntity, _$identity);

  /// Serializes this ClassesDetailsResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ClassesDetailsResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassesDetailsResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.data, _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ClassesDetailsResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,const DeepCollectionEquality().hash(_this.data));
}

@override
String toString() {
  final _this = this as ClassesDetailsResponseEntity;
  return 'ClassesDetailsResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $ClassesDetailsResponseEntityCopyWith<$Res>  {
  factory $ClassesDetailsResponseEntityCopyWith(ClassesDetailsResponseEntity value, $Res Function(ClassesDetailsResponseEntity) _then) = _$ClassesDetailsResponseEntityCopyWithImpl;
@useResult
$Res call({
 int? status, String? message, List<ClassEntity>? data
});




}
/// @nodoc
class _$ClassesDetailsResponseEntityCopyWithImpl<$Res>
    implements $ClassesDetailsResponseEntityCopyWith<$Res> {
  _$ClassesDetailsResponseEntityCopyWithImpl(this._self, this._then);

  final ClassesDetailsResponseEntity _self;
  final $Res Function(ClassesDetailsResponseEntity) _then;

/// Create a copy of ClassesDetailsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(ClassesDetailsResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<ClassEntity>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClassesDetailsResponseEntity].
extension ClassesDetailsResponseEntityPatterns on ClassesDetailsResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassesDetailsResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassesDetailsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassesDetailsResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _ClassesDetailsResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassesDetailsResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ClassesDetailsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? status,  String? message,  List<ClassEntity>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassesDetailsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? status,  String? message,  List<ClassEntity>? data)  $default,) {final _that = this;
switch (_that) {
case _ClassesDetailsResponseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? status,  String? message,  List<ClassEntity>? data)?  $default,) {final _that = this;
switch (_that) {
case _ClassesDetailsResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassesDetailsResponseEntity implements ClassesDetailsResponseEntity {
  const _ClassesDetailsResponseEntity({this.status, this.message,  List<ClassEntity>? data}): _data = data;
  factory _ClassesDetailsResponseEntity.fromJson(Map<String, dynamic> json) => _$ClassesDetailsResponseEntityFromJson(json);

@override final  int? status;
@override final  String? message;
 final  List<ClassEntity>? _data;
@override List<ClassEntity>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ClassesDetailsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassesDetailsResponseEntityCopyWith<_ClassesDetailsResponseEntity> get copyWith => __$ClassesDetailsResponseEntityCopyWithImpl<_ClassesDetailsResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassesDetailsResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassesDetailsResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(_data));
}

@override
String toString() {
    return 'ClassesDetailsResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ClassesDetailsResponseEntityCopyWith<$Res> implements $ClassesDetailsResponseEntityCopyWith<$Res> {
  factory _$ClassesDetailsResponseEntityCopyWith(_ClassesDetailsResponseEntity value, $Res Function(_ClassesDetailsResponseEntity) _then) = __$ClassesDetailsResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 int? status, String? message, List<ClassEntity>? data
});




}
/// @nodoc
class __$ClassesDetailsResponseEntityCopyWithImpl<$Res>
    implements _$ClassesDetailsResponseEntityCopyWith<$Res> {
  __$ClassesDetailsResponseEntityCopyWithImpl(this._self, this._then);

  final _ClassesDetailsResponseEntity _self;
  final $Res Function(_ClassesDetailsResponseEntity) _then;

/// Create a copy of ClassesDetailsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_ClassesDetailsResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<ClassEntity>?,
  ));
}


}

// dart format on
