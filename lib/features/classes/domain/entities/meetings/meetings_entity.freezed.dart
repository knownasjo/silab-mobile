// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meetings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingsEntity {

 String? get id; String? get meetingName; String? get submittedAt; bool? get isAttended; bool? get isOpen;
/// Create a copy of MeetingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingsEntityCopyWith<MeetingsEntity> get copyWith => _$MeetingsEntityCopyWithImpl<MeetingsEntity>(this as MeetingsEntity, _$identity);

  /// Serializes this MeetingsEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MeetingsEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingsEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.meetingName, _this.meetingName) || other.meetingName == _this.meetingName)&&(identical(other.submittedAt, _this.submittedAt) || other.submittedAt == _this.submittedAt)&&(identical(other.isAttended, _this.isAttended) || other.isAttended == _this.isAttended)&&(identical(other.isOpen, _this.isOpen) || other.isOpen == _this.isOpen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MeetingsEntity;
  return Object.hash(runtimeType,_this.id,_this.meetingName,_this.submittedAt,_this.isAttended,_this.isOpen);
}

@override
String toString() {
  final _this = this as MeetingsEntity;
  return 'MeetingsEntity(id: ${_this.id}, meetingName: ${_this.meetingName}, submittedAt: ${_this.submittedAt}, isAttended: ${_this.isAttended}, isOpen: ${_this.isOpen})';
}


}

/// @nodoc
abstract mixin class $MeetingsEntityCopyWith<$Res>  {
  factory $MeetingsEntityCopyWith(MeetingsEntity value, $Res Function(MeetingsEntity) _then) = _$MeetingsEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? meetingName, String? submittedAt, bool? isAttended, bool? isOpen
});




}
/// @nodoc
class _$MeetingsEntityCopyWithImpl<$Res>
    implements $MeetingsEntityCopyWith<$Res> {
  _$MeetingsEntityCopyWithImpl(this._self, this._then);

  final MeetingsEntity _self;
  final $Res Function(MeetingsEntity) _then;

/// Create a copy of MeetingsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? meetingName = freezed,Object? submittedAt = freezed,Object? isAttended = freezed,Object? isOpen = freezed,}) {
  return _then(MeetingsEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,meetingName: freezed == meetingName ? _self.meetingName : meetingName // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,isAttended: freezed == isAttended ? _self.isAttended : isAttended // ignore: cast_nullable_to_non_nullable
as bool?,isOpen: freezed == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingsEntity].
extension MeetingsEntityPatterns on MeetingsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _MeetingsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? meetingName,  String? submittedAt,  bool? isAttended,  bool? isOpen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingsEntity() when $default != null:
return $default(_that.id,_that.meetingName,_that.submittedAt,_that.isAttended,_that.isOpen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? meetingName,  String? submittedAt,  bool? isAttended,  bool? isOpen)  $default,) {final _that = this;
switch (_that) {
case _MeetingsEntity():
return $default(_that.id,_that.meetingName,_that.submittedAt,_that.isAttended,_that.isOpen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? meetingName,  String? submittedAt,  bool? isAttended,  bool? isOpen)?  $default,) {final _that = this;
switch (_that) {
case _MeetingsEntity() when $default != null:
return $default(_that.id,_that.meetingName,_that.submittedAt,_that.isAttended,_that.isOpen);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingsEntity extends MeetingsEntity {
  const _MeetingsEntity({this.id, this.meetingName, this.submittedAt, this.isAttended, this.isOpen}): super._();
  factory _MeetingsEntity.fromJson(Map<String, dynamic> json) => _$MeetingsEntityFromJson(json);

@override final  String? id;
@override final  String? meetingName;
@override final  String? submittedAt;
@override final  bool? isAttended;
@override final  bool? isOpen;

/// Create a copy of MeetingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingsEntityCopyWith<_MeetingsEntity> get copyWith => __$MeetingsEntityCopyWithImpl<_MeetingsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.meetingName, meetingName) || other.meetingName == meetingName)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.isAttended, isAttended) || other.isAttended == isAttended)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,meetingName,submittedAt,isAttended,isOpen);
}

@override
String toString() {
    return 'MeetingsEntity(id: $id, meetingName: $meetingName, submittedAt: $submittedAt, isAttended: $isAttended, isOpen: $isOpen)';
}


}

/// @nodoc
abstract mixin class _$MeetingsEntityCopyWith<$Res> implements $MeetingsEntityCopyWith<$Res> {
  factory _$MeetingsEntityCopyWith(_MeetingsEntity value, $Res Function(_MeetingsEntity) _then) = __$MeetingsEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? meetingName, String? submittedAt, bool? isAttended, bool? isOpen
});




}
/// @nodoc
class __$MeetingsEntityCopyWithImpl<$Res>
    implements _$MeetingsEntityCopyWith<$Res> {
  __$MeetingsEntityCopyWithImpl(this._self, this._then);

  final _MeetingsEntity _self;
  final $Res Function(_MeetingsEntity) _then;

/// Create a copy of MeetingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? meetingName = freezed,Object? submittedAt = freezed,Object? isAttended = freezed,Object? isOpen = freezed,}) {
  return _then(_MeetingsEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,meetingName: freezed == meetingName ? _self.meetingName : meetingName // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,isAttended: freezed == isAttended ? _self.isAttended : isAttended // ignore: cast_nullable_to_non_nullable
as bool?,isOpen: freezed == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
