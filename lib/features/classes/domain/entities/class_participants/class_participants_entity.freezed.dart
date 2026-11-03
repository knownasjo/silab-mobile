// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_participants_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassParticipantsEntity {

 String? get id; String? get email; String? get fullname; String? get nim; List<String>? get role; bool? get paid;
/// Create a copy of ClassParticipantsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassParticipantsEntityCopyWith<ClassParticipantsEntity> get copyWith => _$ClassParticipantsEntityCopyWithImpl<ClassParticipantsEntity>(this as ClassParticipantsEntity, _$identity);

  /// Serializes this ClassParticipantsEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ClassParticipantsEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassParticipantsEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.fullname, _this.fullname) || other.fullname == _this.fullname)&&(identical(other.nim, _this.nim) || other.nim == _this.nim)&&const DeepCollectionEquality().equals(other.role, _this.role)&&(identical(other.paid, _this.paid) || other.paid == _this.paid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ClassParticipantsEntity;
  return Object.hash(runtimeType,_this.id,_this.email,_this.fullname,_this.nim,const DeepCollectionEquality().hash(_this.role),_this.paid);
}

@override
String toString() {
  final _this = this as ClassParticipantsEntity;
  return 'ClassParticipantsEntity(id: ${_this.id}, email: ${_this.email}, fullname: ${_this.fullname}, nim: ${_this.nim}, role: ${_this.role}, paid: ${_this.paid})';
}


}

/// @nodoc
abstract mixin class $ClassParticipantsEntityCopyWith<$Res>  {
  factory $ClassParticipantsEntityCopyWith(ClassParticipantsEntity value, $Res Function(ClassParticipantsEntity) _then) = _$ClassParticipantsEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? email, String? fullname, String? nim, List<String>? role, bool? paid
});




}
/// @nodoc
class _$ClassParticipantsEntityCopyWithImpl<$Res>
    implements $ClassParticipantsEntityCopyWith<$Res> {
  _$ClassParticipantsEntityCopyWithImpl(this._self, this._then);

  final ClassParticipantsEntity _self;
  final $Res Function(ClassParticipantsEntity) _then;

/// Create a copy of ClassParticipantsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? email = freezed,Object? fullname = freezed,Object? nim = freezed,Object? role = freezed,Object? paid = freezed,}) {
  return _then(ClassParticipantsEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as String?,nim: freezed == nim ? _self.nim : nim // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as List<String>?,paid: freezed == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClassParticipantsEntity].
extension ClassParticipantsEntityPatterns on ClassParticipantsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassParticipantsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassParticipantsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassParticipantsEntity value)  $default,){
final _that = this;
switch (_that) {
case _ClassParticipantsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassParticipantsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ClassParticipantsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? email,  String? fullname,  String? nim,  List<String>? role,  bool? paid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassParticipantsEntity() when $default != null:
return $default(_that.id,_that.email,_that.fullname,_that.nim,_that.role,_that.paid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? email,  String? fullname,  String? nim,  List<String>? role,  bool? paid)  $default,) {final _that = this;
switch (_that) {
case _ClassParticipantsEntity():
return $default(_that.id,_that.email,_that.fullname,_that.nim,_that.role,_that.paid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? email,  String? fullname,  String? nim,  List<String>? role,  bool? paid)?  $default,) {final _that = this;
switch (_that) {
case _ClassParticipantsEntity() when $default != null:
return $default(_that.id,_that.email,_that.fullname,_that.nim,_that.role,_that.paid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassParticipantsEntity implements ClassParticipantsEntity {
  const _ClassParticipantsEntity({this.id, this.email, this.fullname, this.nim,  List<String>? role, this.paid}): _role = role;
  factory _ClassParticipantsEntity.fromJson(Map<String, dynamic> json) => _$ClassParticipantsEntityFromJson(json);

@override final  String? id;
@override final  String? email;
@override final  String? fullname;
@override final  String? nim;
 final  List<String>? _role;
@override List<String>? get role {
  final value = _role;
  if (value == null) return null;
  if (_role is EqualUnmodifiableListView) return _role;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? paid;

/// Create a copy of ClassParticipantsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassParticipantsEntityCopyWith<_ClassParticipantsEntity> get copyWith => __$ClassParticipantsEntityCopyWithImpl<_ClassParticipantsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassParticipantsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassParticipantsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullname, fullname) || other.fullname == fullname)&&(identical(other.nim, nim) || other.nim == nim)&&const DeepCollectionEquality().equals(other.role, _role)&&(identical(other.paid, paid) || other.paid == paid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,fullname,nim,const DeepCollectionEquality().hash(_role),paid);
}

@override
String toString() {
    return 'ClassParticipantsEntity(id: $id, email: $email, fullname: $fullname, nim: $nim, role: $role, paid: $paid)';
}


}

/// @nodoc
abstract mixin class _$ClassParticipantsEntityCopyWith<$Res> implements $ClassParticipantsEntityCopyWith<$Res> {
  factory _$ClassParticipantsEntityCopyWith(_ClassParticipantsEntity value, $Res Function(_ClassParticipantsEntity) _then) = __$ClassParticipantsEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? email, String? fullname, String? nim, List<String>? role, bool? paid
});




}
/// @nodoc
class __$ClassParticipantsEntityCopyWithImpl<$Res>
    implements _$ClassParticipantsEntityCopyWith<$Res> {
  __$ClassParticipantsEntityCopyWithImpl(this._self, this._then);

  final _ClassParticipantsEntity _self;
  final $Res Function(_ClassParticipantsEntity) _then;

/// Create a copy of ClassParticipantsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? email = freezed,Object? fullname = freezed,Object? nim = freezed,Object? role = freezed,Object? paid = freezed,}) {
  return _then(_ClassParticipantsEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as String?,nim: freezed == nim ? _self.nim : nim // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self._role : role // ignore: cast_nullable_to_non_nullable
as List<String>?,paid: freezed == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
