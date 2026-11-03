// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_selected_subject_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddSelectedSubjectResponseEntity {

 bool? get status; String? get message; AddSubjectSubjectsEntity? get data;
/// Create a copy of AddSelectedSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddSelectedSubjectResponseEntityCopyWith<AddSelectedSubjectResponseEntity> get copyWith => _$AddSelectedSubjectResponseEntityCopyWithImpl<AddSelectedSubjectResponseEntity>(this as AddSelectedSubjectResponseEntity, _$identity);

  /// Serializes this AddSelectedSubjectResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddSelectedSubjectResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddSelectedSubjectResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddSelectedSubjectResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as AddSelectedSubjectResponseEntity;
  return 'AddSelectedSubjectResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $AddSelectedSubjectResponseEntityCopyWith<$Res>  {
  factory $AddSelectedSubjectResponseEntityCopyWith(AddSelectedSubjectResponseEntity value, $Res Function(AddSelectedSubjectResponseEntity) _then) = _$AddSelectedSubjectResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message, AddSubjectSubjectsEntity? data
});


$AddSubjectSubjectsEntityCopyWith<$Res>? get data;

}
/// @nodoc
class _$AddSelectedSubjectResponseEntityCopyWithImpl<$Res>
    implements $AddSelectedSubjectResponseEntityCopyWith<$Res> {
  _$AddSelectedSubjectResponseEntityCopyWithImpl(this._self, this._then);

  final AddSelectedSubjectResponseEntity _self;
  final $Res Function(AddSelectedSubjectResponseEntity) _then;

/// Create a copy of AddSelectedSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(AddSelectedSubjectResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AddSubjectSubjectsEntity?,
  ));
}
/// Create a copy of AddSelectedSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddSubjectSubjectsEntityCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AddSubjectSubjectsEntityCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddSelectedSubjectResponseEntity].
extension AddSelectedSubjectResponseEntityPatterns on AddSelectedSubjectResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddSelectedSubjectResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddSelectedSubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddSelectedSubjectResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _AddSelectedSubjectResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddSelectedSubjectResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AddSelectedSubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? status,  String? message,  AddSubjectSubjectsEntity? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddSelectedSubjectResponseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? status,  String? message,  AddSubjectSubjectsEntity? data)  $default,) {final _that = this;
switch (_that) {
case _AddSelectedSubjectResponseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? status,  String? message,  AddSubjectSubjectsEntity? data)?  $default,) {final _that = this;
switch (_that) {
case _AddSelectedSubjectResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddSelectedSubjectResponseEntity implements AddSelectedSubjectResponseEntity {
  const _AddSelectedSubjectResponseEntity({this.status, this.message, this.data});
  factory _AddSelectedSubjectResponseEntity.fromJson(Map<String, dynamic> json) => _$AddSelectedSubjectResponseEntityFromJson(json);

@override final  bool? status;
@override final  String? message;
@override final  AddSubjectSubjectsEntity? data;

/// Create a copy of AddSelectedSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddSelectedSubjectResponseEntityCopyWith<_AddSelectedSubjectResponseEntity> get copyWith => __$AddSelectedSubjectResponseEntityCopyWithImpl<_AddSelectedSubjectResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddSelectedSubjectResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddSelectedSubjectResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,data);
}

@override
String toString() {
    return 'AddSelectedSubjectResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AddSelectedSubjectResponseEntityCopyWith<$Res> implements $AddSelectedSubjectResponseEntityCopyWith<$Res> {
  factory _$AddSelectedSubjectResponseEntityCopyWith(_AddSelectedSubjectResponseEntity value, $Res Function(_AddSelectedSubjectResponseEntity) _then) = __$AddSelectedSubjectResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message, AddSubjectSubjectsEntity? data
});


@override $AddSubjectSubjectsEntityCopyWith<$Res>? get data;

}
/// @nodoc
class __$AddSelectedSubjectResponseEntityCopyWithImpl<$Res>
    implements _$AddSelectedSubjectResponseEntityCopyWith<$Res> {
  __$AddSelectedSubjectResponseEntityCopyWithImpl(this._self, this._then);

  final _AddSelectedSubjectResponseEntity _self;
  final $Res Function(_AddSelectedSubjectResponseEntity) _then;

/// Create a copy of AddSelectedSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_AddSelectedSubjectResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AddSubjectSubjectsEntity?,
  ));
}

/// Create a copy of AddSelectedSubjectResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddSubjectSubjectsEntityCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AddSubjectSubjectsEntityCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
