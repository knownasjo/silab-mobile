// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnnouncementResponseEntity {

 bool? get status; String? get message; AnnouncementEntity? get data;
/// Create a copy of AnnouncementResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementResponseEntityCopyWith<AnnouncementResponseEntity> get copyWith => _$AnnouncementResponseEntityCopyWithImpl<AnnouncementResponseEntity>(this as AnnouncementResponseEntity, _$identity);

  /// Serializes this AnnouncementResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnnouncementResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnnouncementResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as AnnouncementResponseEntity;
  return 'AnnouncementResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $AnnouncementResponseEntityCopyWith<$Res>  {
  factory $AnnouncementResponseEntityCopyWith(AnnouncementResponseEntity value, $Res Function(AnnouncementResponseEntity) _then) = _$AnnouncementResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message, AnnouncementEntity? data
});


$AnnouncementEntityCopyWith<$Res>? get data;

}
/// @nodoc
class _$AnnouncementResponseEntityCopyWithImpl<$Res>
    implements $AnnouncementResponseEntityCopyWith<$Res> {
  _$AnnouncementResponseEntityCopyWithImpl(this._self, this._then);

  final AnnouncementResponseEntity _self;
  final $Res Function(AnnouncementResponseEntity) _then;

/// Create a copy of AnnouncementResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(AnnouncementResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AnnouncementEntity?,
  ));
}
/// Create a copy of AnnouncementResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnouncementEntityCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AnnouncementEntityCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnnouncementResponseEntity].
extension AnnouncementResponseEntityPatterns on AnnouncementResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? status,  String? message,  AnnouncementEntity? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementResponseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? status,  String? message,  AnnouncementEntity? data)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementResponseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? status,  String? message,  AnnouncementEntity? data)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementResponseEntity implements AnnouncementResponseEntity {
  const _AnnouncementResponseEntity({this.status, this.message, this.data});
  factory _AnnouncementResponseEntity.fromJson(Map<String, dynamic> json) => _$AnnouncementResponseEntityFromJson(json);

@override final  bool? status;
@override final  String? message;
@override final  AnnouncementEntity? data;

/// Create a copy of AnnouncementResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementResponseEntityCopyWith<_AnnouncementResponseEntity> get copyWith => __$AnnouncementResponseEntityCopyWithImpl<_AnnouncementResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,data);
}

@override
String toString() {
    return 'AnnouncementResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementResponseEntityCopyWith<$Res> implements $AnnouncementResponseEntityCopyWith<$Res> {
  factory _$AnnouncementResponseEntityCopyWith(_AnnouncementResponseEntity value, $Res Function(_AnnouncementResponseEntity) _then) = __$AnnouncementResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message, AnnouncementEntity? data
});


@override $AnnouncementEntityCopyWith<$Res>? get data;

}
/// @nodoc
class __$AnnouncementResponseEntityCopyWithImpl<$Res>
    implements _$AnnouncementResponseEntityCopyWith<$Res> {
  __$AnnouncementResponseEntityCopyWithImpl(this._self, this._then);

  final _AnnouncementResponseEntity _self;
  final $Res Function(_AnnouncementResponseEntity) _then;

/// Create a copy of AnnouncementResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_AnnouncementResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AnnouncementEntity?,
  ));
}

/// Create a copy of AnnouncementResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnouncementEntityCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AnnouncementEntityCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
