// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_list_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnnouncementListResponseEntity {

 bool? get status; String? get message; List<AnnouncementEntity>? get data;
/// Create a copy of AnnouncementListResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementListResponseEntityCopyWith<AnnouncementListResponseEntity> get copyWith => _$AnnouncementListResponseEntityCopyWithImpl<AnnouncementListResponseEntity>(this as AnnouncementListResponseEntity, _$identity);

  /// Serializes this AnnouncementListResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnnouncementListResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementListResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.data, _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnnouncementListResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,const DeepCollectionEquality().hash(_this.data));
}

@override
String toString() {
  final _this = this as AnnouncementListResponseEntity;
  return 'AnnouncementListResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $AnnouncementListResponseEntityCopyWith<$Res>  {
  factory $AnnouncementListResponseEntityCopyWith(AnnouncementListResponseEntity value, $Res Function(AnnouncementListResponseEntity) _then) = _$AnnouncementListResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message, List<AnnouncementEntity>? data
});




}
/// @nodoc
class _$AnnouncementListResponseEntityCopyWithImpl<$Res>
    implements $AnnouncementListResponseEntityCopyWith<$Res> {
  _$AnnouncementListResponseEntityCopyWithImpl(this._self, this._then);

  final AnnouncementListResponseEntity _self;
  final $Res Function(AnnouncementListResponseEntity) _then;

/// Create a copy of AnnouncementListResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(AnnouncementListResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<AnnouncementEntity>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementListResponseEntity].
extension AnnouncementListResponseEntityPatterns on AnnouncementListResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementListResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementListResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementListResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementListResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementListResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementListResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? status,  String? message,  List<AnnouncementEntity>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementListResponseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? status,  String? message,  List<AnnouncementEntity>? data)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementListResponseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? status,  String? message,  List<AnnouncementEntity>? data)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementListResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementListResponseEntity implements AnnouncementListResponseEntity {
  const _AnnouncementListResponseEntity({this.status, this.message,  List<AnnouncementEntity>? data}): _data = data;
  factory _AnnouncementListResponseEntity.fromJson(Map<String, dynamic> json) => _$AnnouncementListResponseEntityFromJson(json);

@override final  bool? status;
@override final  String? message;
 final  List<AnnouncementEntity>? _data;
@override List<AnnouncementEntity>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AnnouncementListResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementListResponseEntityCopyWith<_AnnouncementListResponseEntity> get copyWith => __$AnnouncementListResponseEntityCopyWithImpl<_AnnouncementListResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementListResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementListResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(_data));
}

@override
String toString() {
    return 'AnnouncementListResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementListResponseEntityCopyWith<$Res> implements $AnnouncementListResponseEntityCopyWith<$Res> {
  factory _$AnnouncementListResponseEntityCopyWith(_AnnouncementListResponseEntity value, $Res Function(_AnnouncementListResponseEntity) _then) = __$AnnouncementListResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message, List<AnnouncementEntity>? data
});




}
/// @nodoc
class __$AnnouncementListResponseEntityCopyWithImpl<$Res>
    implements _$AnnouncementListResponseEntityCopyWith<$Res> {
  __$AnnouncementListResponseEntityCopyWithImpl(this._self, this._then);

  final _AnnouncementListResponseEntity _self;
  final $Res Function(_AnnouncementListResponseEntity) _then;

/// Create a copy of AnnouncementListResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_AnnouncementListResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<AnnouncementEntity>?,
  ));
}


}

// dart format on
