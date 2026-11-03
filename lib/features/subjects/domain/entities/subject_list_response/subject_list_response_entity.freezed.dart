// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_list_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectListResponseEntity {

 bool? get status; String? get message; List<SubjectEntity>? get data;
/// Create a copy of SubjectListResponseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectListResponseEntityCopyWith<SubjectListResponseEntity> get copyWith => _$SubjectListResponseEntityCopyWithImpl<SubjectListResponseEntity>(this as SubjectListResponseEntity, _$identity);

  /// Serializes this SubjectListResponseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubjectListResponseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectListResponseEntity&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.data, _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubjectListResponseEntity;
  return Object.hash(runtimeType,_this.status,_this.message,const DeepCollectionEquality().hash(_this.data));
}

@override
String toString() {
  final _this = this as SubjectListResponseEntity;
  return 'SubjectListResponseEntity(status: ${_this.status}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $SubjectListResponseEntityCopyWith<$Res>  {
  factory $SubjectListResponseEntityCopyWith(SubjectListResponseEntity value, $Res Function(SubjectListResponseEntity) _then) = _$SubjectListResponseEntityCopyWithImpl;
@useResult
$Res call({
 bool? status, String? message, List<SubjectEntity>? data
});




}
/// @nodoc
class _$SubjectListResponseEntityCopyWithImpl<$Res>
    implements $SubjectListResponseEntityCopyWith<$Res> {
  _$SubjectListResponseEntityCopyWithImpl(this._self, this._then);

  final SubjectListResponseEntity _self;
  final $Res Function(SubjectListResponseEntity) _then;

/// Create a copy of SubjectListResponseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(SubjectListResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<SubjectEntity>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubjectListResponseEntity].
extension SubjectListResponseEntityPatterns on SubjectListResponseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectListResponseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectListResponseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectListResponseEntity value)  $default,){
final _that = this;
switch (_that) {
case _SubjectListResponseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectListResponseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectListResponseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? status,  String? message,  List<SubjectEntity>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectListResponseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? status,  String? message,  List<SubjectEntity>? data)  $default,) {final _that = this;
switch (_that) {
case _SubjectListResponseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? status,  String? message,  List<SubjectEntity>? data)?  $default,) {final _that = this;
switch (_that) {
case _SubjectListResponseEntity() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubjectListResponseEntity implements SubjectListResponseEntity {
  const _SubjectListResponseEntity({this.status, this.message,  List<SubjectEntity>? data}): _data = data;
  factory _SubjectListResponseEntity.fromJson(Map<String, dynamic> json) => _$SubjectListResponseEntityFromJson(json);

@override final  bool? status;
@override final  String? message;
 final  List<SubjectEntity>? _data;
@override List<SubjectEntity>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SubjectListResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectListResponseEntityCopyWith<_SubjectListResponseEntity> get copyWith => __$SubjectListResponseEntityCopyWithImpl<_SubjectListResponseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubjectListResponseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectListResponseEntity&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(_data));
}

@override
String toString() {
    return 'SubjectListResponseEntity(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SubjectListResponseEntityCopyWith<$Res> implements $SubjectListResponseEntityCopyWith<$Res> {
  factory _$SubjectListResponseEntityCopyWith(_SubjectListResponseEntity value, $Res Function(_SubjectListResponseEntity) _then) = __$SubjectListResponseEntityCopyWithImpl;
@override @useResult
$Res call({
 bool? status, String? message, List<SubjectEntity>? data
});




}
/// @nodoc
class __$SubjectListResponseEntityCopyWithImpl<$Res>
    implements _$SubjectListResponseEntityCopyWith<$Res> {
  __$SubjectListResponseEntityCopyWithImpl(this._self, this._then);

  final _SubjectListResponseEntity _self;
  final $Res Function(_SubjectListResponseEntity) _then;

/// Create a copy of SubjectListResponseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SubjectListResponseEntity(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<SubjectEntity>?,
  ));
}


}

// dart format on
