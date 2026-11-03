// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectResponseEntity {

 bool? get status; String? get message; SubjectEntity? get data;
/// Create a copy of SubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectResponseEntityCopyWith<SubjectResponseEntity> get copyWith => _$SubjectResponseEntityCopyWithImpl<SubjectResponseEntity>(this as SubjectResponseEntity, _$identity);

  /// Serializes this SubjectResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubjectResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubjectResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as SubjectResponseEntity;
  return 'SubjectResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $SubjectResponseEntityCopyWith<$Res>  {
  factory $SubjectResponseEntityCopyWith(SubjectResponseEntity value, $Res Function(SubjectResponseEntity) _then) = _$SubjectResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message, SubjectEntity? data
});


$SubjectEntityCopyWith<$Res>? get data;

}
/// @nodoc
class _$SubjectResponseEntityCopyWithImpl<$Res>
    implements $SubjectResponseEntityCopyWith<$Res> {
  _$SubjectResponseEntityCopyWithImpl(this._self, this._then);

  final SubjectResponseEntity _self;
  final $Res Function(SubjectResponseEntity) _then;

/// Create a copy of SubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(SubjectResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SubjectEntity?,
  ));
}
/// Create a copy of SubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectEntityCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SubjectEntityCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubjectResponseEntity].
extension SubjectResponseEntityPatterns on SubjectResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _SubjectResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? status,  String? message,  SubjectEntity? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? status,  String? message,  SubjectEntity? data)  $default,) {final _that = this;
switch (_that) {
case _SubjectResponseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? status,  String? message,  SubjectEntity? data)?  $default,) {final _that = this;
switch (_that) {
case _SubjectResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubjectResponseEntity implements SubjectResponseEntity {
  const _SubjectResponseEntity({this.status, this.message, this.data});
  factory _SubjectResponseEntity.fromJson(Map<String, dynamic> json) => _$SubjectResponseEntityFromJson(json);

@override final  bool? status;
@override final  String? message;
@override final  SubjectEntity? data;

/// Create a copy of SubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectResponseEntityCopyWith<_SubjectResponseEntity> get copyWith => __$SubjectResponseEntityCopyWithImpl<_SubjectResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubjectResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,data);
}

@override
String toString() {
    return 'SubjectResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SubjectResponseEntityCopyWith<$Res> implements $SubjectResponseEntityCopyWith<$Res> {
  factory _$SubjectResponseEntityCopyWith(_SubjectResponseEntity value, $Res Function(_SubjectResponseEntity) _then) = __$SubjectResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message, SubjectEntity? data
});


@override $SubjectEntityCopyWith<$Res>? get data;

}
/// @nodoc
class __$SubjectResponseEntityCopyWithImpl<$Res>
    implements _$SubjectResponseEntityCopyWith<$Res> {
  __$SubjectResponseEntityCopyWithImpl(this._self, this._then);

  final _SubjectResponseEntity _self;
  final $Res Function(_SubjectResponseEntity) _then;

/// Create a copy of SubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SubjectResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SubjectEntity?,
  ));
}

/// Create a copy of SubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectEntityCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SubjectEntityCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
