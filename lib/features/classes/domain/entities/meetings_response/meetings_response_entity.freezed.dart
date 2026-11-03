// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meetings_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingsResponseEntity {

 bool? get status; String? get message; List<MeetingsEntity>? get data;
/// Create a copy of MeetingsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingsResponseEntityCopyWith<MeetingsResponseEntity> get copyWith => _$MeetingsResponseEntityCopyWithImpl<MeetingsResponseEntity>(this as MeetingsResponseEntity, _$identity);

  /// Serializes this MeetingsResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeetingsResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingsResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.data, _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeetingsResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,const DeepCollectionEquality().hash(_this.data));
}

@override
String toString() {
  final _this = this as MeetingsResponseEntity;
  return 'MeetingsResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $MeetingsResponseEntityCopyWith<$Res>  {
  factory $MeetingsResponseEntityCopyWith(MeetingsResponseEntity value, $Res Function(MeetingsResponseEntity) _then) = _$MeetingsResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message, List<MeetingsEntity>? data
});




}
/// @nodoc
class _$MeetingsResponseEntityCopyWithImpl<$Res>
    implements $MeetingsResponseEntityCopyWith<$Res> {
  _$MeetingsResponseEntityCopyWithImpl(this._self, this._then);

  final MeetingsResponseEntity _self;
  final $Res Function(MeetingsResponseEntity) _then;

/// Create a copy of MeetingsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(MeetingsResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<MeetingsEntity>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingsResponseEntity].
extension MeetingsResponseEntityPatterns on MeetingsResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingsResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingsResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _MeetingsResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingsResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? status,  String? message,  List<MeetingsEntity>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingsResponseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? status,  String? message,  List<MeetingsEntity>? data)  $default,) {final _that = this;
switch (_that) {
case _MeetingsResponseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? status,  String? message,  List<MeetingsEntity>? data)?  $default,) {final _that = this;
switch (_that) {
case _MeetingsResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingsResponseEntity implements MeetingsResponseEntity {
  const _MeetingsResponseEntity({this.status, this.message,  List<MeetingsEntity>? data}): _data = data;
  factory _MeetingsResponseEntity.fromJson(Map<String, dynamic> json) => _$MeetingsResponseEntityFromJson(json);

@override final  bool? status;
@override final  String? message;
 final  List<MeetingsEntity>? _data;
@override List<MeetingsEntity>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of MeetingsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingsResponseEntityCopyWith<_MeetingsResponseEntity> get copyWith => __$MeetingsResponseEntityCopyWithImpl<_MeetingsResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingsResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingsResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(_data));
}

@override
String toString() {
    return 'MeetingsResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$MeetingsResponseEntityCopyWith<$Res> implements $MeetingsResponseEntityCopyWith<$Res> {
  factory _$MeetingsResponseEntityCopyWith(_MeetingsResponseEntity value, $Res Function(_MeetingsResponseEntity) _then) = __$MeetingsResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message, List<MeetingsEntity>? data
});




}
/// @nodoc
class __$MeetingsResponseEntityCopyWithImpl<$Res>
    implements _$MeetingsResponseEntityCopyWith<$Res> {
  __$MeetingsResponseEntityCopyWithImpl(this._self, this._then);

  final _MeetingsResponseEntity _self;
  final $Res Function(_MeetingsResponseEntity) _then;

/// Create a copy of MeetingsResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_MeetingsResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<MeetingsEntity>?,
  ));
}


}

// dart format on
