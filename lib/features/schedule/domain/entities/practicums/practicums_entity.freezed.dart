// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practicums_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PracticumsEntity {

 String? get subjectName; String? get subjectClass; String? get session; String? get classId; String? get room; bool? get isAssistant; ClassEntity? get classEntity;
/// Create a copy of PracticumsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticumsEntityCopyWith<PracticumsEntity> get copyWith => _$PracticumsEntityCopyWithImpl<PracticumsEntity>(this as PracticumsEntity, _$identity);

  /// Serializes this PracticumsEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PracticumsEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticumsEntity&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.subjectClass, _this.subjectClass) || other.subjectClass == _this.subjectClass)&&(identical(other.session, _this.session) || other.session == _this.session)&&(identical(other.classId, _this.classId) || other.classId == _this.classId)&&(identical(other.room, _this.room) || other.room == _this.room)&&(identical(other.isAssistant, _this.isAssistant) || other.isAssistant == _this.isAssistant)&&(identical(other.classEntity, _this.classEntity) || other.classEntity == _this.classEntity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PracticumsEntity;
  return Object.hash(runtimeType,_this.subjectName,_this.subjectClass,_this.session,_this.classId,_this.room,_this.isAssistant,_this.classEntity);
}

@override
String toString() {
  final _this = this as PracticumsEntity;
  return 'PracticumsEntity(subjectName: ${_this.subjectName}, subjectClass: ${_this.subjectClass}, session: ${_this.session}, classId: ${_this.classId}, room: ${_this.room}, isAssistant: ${_this.isAssistant}, classEntity: ${_this.classEntity})';
}


}

/// @nodoc
abstract mixin class $PracticumsEntityCopyWith<$Res>  {
  factory $PracticumsEntityCopyWith(PracticumsEntity value, $Res Function(PracticumsEntity) _then) = _$PracticumsEntityCopyWithImpl;
@useResult
$Res call({
 String? subjectName, String? subjectClass, String? session, String? classId, String? room, bool? isAssistant, ClassEntity? classEntity
});


$ClassEntityCopyWith<$Res>? get classEntity;

}
/// @nodoc
class _$PracticumsEntityCopyWithImpl<$Res>
    implements $PracticumsEntityCopyWith<$Res> {
  _$PracticumsEntityCopyWithImpl(this._self, this._then);

  final PracticumsEntity _self;
  final $Res Function(PracticumsEntity) _then;

/// Create a copy of PracticumsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subjectName = freezed,Object? subjectClass = freezed,Object? session = freezed,Object? classId = freezed,Object? room = freezed,Object? isAssistant = freezed,Object? classEntity = freezed,}) {
  return _then(PracticumsEntity(
subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,subjectClass: freezed == subjectClass ? _self.subjectClass : subjectClass // ignore: cast_nullable_to_non_nullable
as String?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as String?,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,isAssistant: freezed == isAssistant ? _self.isAssistant : isAssistant // ignore: cast_nullable_to_non_nullable
as bool?,classEntity: freezed == classEntity ? _self.classEntity : classEntity // ignore: cast_nullable_to_non_nullable
as ClassEntity?,
  ));
}
/// Create a copy of PracticumsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassEntityCopyWith<$Res>? get classEntity {
    if (_self.classEntity == null) {
    return null;
  }

  return $ClassEntityCopyWith<$Res>(_self.classEntity!, (value) {
    return _then(_self.copyWith(classEntity: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticumsEntity].
extension PracticumsEntityPatterns on PracticumsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticumsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticumsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticumsEntity value)  $default,){
final _that = this;
switch (_that) {
case _PracticumsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticumsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PracticumsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? subjectName,  String? subjectClass,  String? session,  String? classId,  String? room,  bool? isAssistant,  ClassEntity? classEntity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticumsEntity() when $default != null:
return $default(_that.subjectName,_that.subjectClass,_that.session,_that.classId,_that.room,_that.isAssistant,_that.classEntity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? subjectName,  String? subjectClass,  String? session,  String? classId,  String? room,  bool? isAssistant,  ClassEntity? classEntity)  $default,) {final _that = this;
switch (_that) {
case _PracticumsEntity():
return $default(_that.subjectName,_that.subjectClass,_that.session,_that.classId,_that.room,_that.isAssistant,_that.classEntity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? subjectName,  String? subjectClass,  String? session,  String? classId,  String? room,  bool? isAssistant,  ClassEntity? classEntity)?  $default,) {final _that = this;
switch (_that) {
case _PracticumsEntity() when $default != null:
return $default(_that.subjectName,_that.subjectClass,_that.session,_that.classId,_that.room,_that.isAssistant,_that.classEntity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticumsEntity implements PracticumsEntity {
  const _PracticumsEntity({this.subjectName, this.subjectClass, this.session, this.classId, this.room, this.isAssistant, this.classEntity});
  factory _PracticumsEntity.fromJson(Map<String, dynamic> json) => _$PracticumsEntityFromJson(json);

@override final  String? subjectName;
@override final  String? subjectClass;
@override final  String? session;
@override final  String? classId;
@override final  String? room;
@override final  bool? isAssistant;
@override final  ClassEntity? classEntity;

/// Create a copy of PracticumsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticumsEntityCopyWith<_PracticumsEntity> get copyWith => __$PracticumsEntityCopyWithImpl<_PracticumsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticumsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticumsEntity&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.subjectClass, subjectClass) || other.subjectClass == subjectClass)&&(identical(other.session, session) || other.session == session)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.room, room) || other.room == room)&&(identical(other.isAssistant, isAssistant) || other.isAssistant == isAssistant)&&(identical(other.classEntity, classEntity) || other.classEntity == classEntity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,subjectName,subjectClass,session,classId,room,isAssistant,classEntity);
}

@override
String toString() {
    return 'PracticumsEntity(subjectName: $subjectName, subjectClass: $subjectClass, session: $session, classId: $classId, room: $room, isAssistant: $isAssistant, classEntity: $classEntity)';
}


}

/// @nodoc
abstract mixin class _$PracticumsEntityCopyWith<$Res> implements $PracticumsEntityCopyWith<$Res> {
  factory _$PracticumsEntityCopyWith(_PracticumsEntity value, $Res Function(_PracticumsEntity) _then) = __$PracticumsEntityCopyWithImpl;
@override @useResult
$Res call({
 String? subjectName, String? subjectClass, String? session, String? classId, String? room, bool? isAssistant, ClassEntity? classEntity
});


@override $ClassEntityCopyWith<$Res>? get classEntity;

}
/// @nodoc
class __$PracticumsEntityCopyWithImpl<$Res>
    implements _$PracticumsEntityCopyWith<$Res> {
  __$PracticumsEntityCopyWithImpl(this._self, this._then);

  final _PracticumsEntity _self;
  final $Res Function(_PracticumsEntity) _then;

/// Create a copy of PracticumsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subjectName = freezed,Object? subjectClass = freezed,Object? session = freezed,Object? classId = freezed,Object? room = freezed,Object? isAssistant = freezed,Object? classEntity = freezed,}) {
  return _then(_PracticumsEntity(
subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,subjectClass: freezed == subjectClass ? _self.subjectClass : subjectClass // ignore: cast_nullable_to_non_nullable
as String?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as String?,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,isAssistant: freezed == isAssistant ? _self.isAssistant : isAssistant // ignore: cast_nullable_to_non_nullable
as bool?,classEntity: freezed == classEntity ? _self.classEntity : classEntity // ignore: cast_nullable_to_non_nullable
as ClassEntity?,
  ));
}

/// Create a copy of PracticumsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassEntityCopyWith<$Res>? get classEntity {
    if (_self.classEntity == null) {
    return null;
  }

  return $ClassEntityCopyWith<$Res>(_self.classEntity!, (value) {
    return _then(_self.copyWith(classEntity: value));
  });
}
}

// dart format on
