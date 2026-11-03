// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registered_class_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisteredClassEntity {

 String? get id; String? get subject; String? get name; int? get quota; bool? get isFull; String? get day; String? get startAt; String? get endAt; String? get ruang; List<String>? get participants; List<String>? get learningModule;
/// Create a copy of RegisteredClassEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisteredClassEntityCopyWith<RegisteredClassEntity> get copyWith => _$RegisteredClassEntityCopyWithImpl<RegisteredClassEntity>(this as RegisteredClassEntity, _$identity);

  /// Serializes this RegisteredClassEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegisteredClassEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisteredClassEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.quota, _this.quota) || other.quota == _this.quota)&&(identical(other.isFull, _this.isFull) || other.isFull == _this.isFull)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.startAt, _this.startAt) || other.startAt == _this.startAt)&&(identical(other.endAt, _this.endAt) || other.endAt == _this.endAt)&&(identical(other.ruang, _this.ruang) || other.ruang == _this.ruang)&&const DeepCollectionEquality().equals(other.participants, _this.participants)&&const DeepCollectionEquality().equals(other.learningModule, _this.learningModule));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegisteredClassEntity;
  return Object.hash(runtimeType,_this.id,_this.subject,_this.name,_this.quota,_this.isFull,_this.day,_this.startAt,_this.endAt,_this.ruang,const DeepCollectionEquality().hash(_this.participants),const DeepCollectionEquality().hash(_this.learningModule));
}

@override
String toString() {
  final _this = this as RegisteredClassEntity;
  return 'RegisteredClassEntity(id: ${_this.id}, subject: ${_this.subject}, name: ${_this.name}, quota: ${_this.quota}, isFull: ${_this.isFull}, day: ${_this.day}, startAt: ${_this.startAt}, endAt: ${_this.endAt}, ruang: ${_this.ruang}, participants: ${_this.participants}, learningModule: ${_this.learningModule})';
}


}

/// @nodoc
abstract mixin class $RegisteredClassEntityCopyWith<$Res>  {
  factory $RegisteredClassEntityCopyWith(RegisteredClassEntity value, $Res Function(RegisteredClassEntity) _then) = _$RegisteredClassEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? subject, String? name, int? quota, bool? isFull, String? day, String? startAt, String? endAt, String? ruang, List<String>? participants, List<String>? learningModule
});




}
/// @nodoc
class _$RegisteredClassEntityCopyWithImpl<$Res>
    implements $RegisteredClassEntityCopyWith<$Res> {
  _$RegisteredClassEntityCopyWithImpl(this._self, this._then);

  final RegisteredClassEntity _self;
  final $Res Function(RegisteredClassEntity) _then;

/// Create a copy of RegisteredClassEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? subject = freezed,Object? name = freezed,Object? quota = freezed,Object? isFull = freezed,Object? day = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? ruang = freezed,Object? participants = freezed,Object? learningModule = freezed,}) {
  return _then(RegisteredClassEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as int?,isFull: freezed == isFull ? _self.isFull : isFull // ignore: cast_nullable_to_non_nullable
as bool?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String?,ruang: freezed == ruang ? _self.ruang : ruang // ignore: cast_nullable_to_non_nullable
as String?,participants: freezed == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>?,learningModule: freezed == learningModule ? _self.learningModule : learningModule // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisteredClassEntity].
extension RegisteredClassEntityPatterns on RegisteredClassEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisteredClassEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisteredClassEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisteredClassEntity value)  $default,){
final _that = this;
switch (_that) {
case _RegisteredClassEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisteredClassEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RegisteredClassEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? subject,  String? name,  int? quota,  bool? isFull,  String? day,  String? startAt,  String? endAt,  String? ruang,  List<String>? participants,  List<String>? learningModule)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisteredClassEntity() when $default != null:
return $default(_that.id,_that.subject,_that.name,_that.quota,_that.isFull,_that.day,_that.startAt,_that.endAt,_that.ruang,_that.participants,_that.learningModule);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? subject,  String? name,  int? quota,  bool? isFull,  String? day,  String? startAt,  String? endAt,  String? ruang,  List<String>? participants,  List<String>? learningModule)  $default,) {final _that = this;
switch (_that) {
case _RegisteredClassEntity():
return $default(_that.id,_that.subject,_that.name,_that.quota,_that.isFull,_that.day,_that.startAt,_that.endAt,_that.ruang,_that.participants,_that.learningModule);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? subject,  String? name,  int? quota,  bool? isFull,  String? day,  String? startAt,  String? endAt,  String? ruang,  List<String>? participants,  List<String>? learningModule)?  $default,) {final _that = this;
switch (_that) {
case _RegisteredClassEntity() when $default != null:
return $default(_that.id,_that.subject,_that.name,_that.quota,_that.isFull,_that.day,_that.startAt,_that.endAt,_that.ruang,_that.participants,_that.learningModule);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisteredClassEntity implements RegisteredClassEntity {
  const _RegisteredClassEntity({this.id, this.subject, this.name, this.quota, this.isFull, this.day, this.startAt, this.endAt, this.ruang,  List<String>? participants,  List<String>? learningModule}): _participants = participants,_learningModule = learningModule;
  factory _RegisteredClassEntity.fromJson(Map<String, dynamic> json) => _$RegisteredClassEntityFromJson(json);

@override final  String? id;
@override final  String? subject;
@override final  String? name;
@override final  int? quota;
@override final  bool? isFull;
@override final  String? day;
@override final  String? startAt;
@override final  String? endAt;
@override final  String? ruang;
 final  List<String>? _participants;
@override List<String>? get participants {
  final value = _participants;
  if (value == null) return null;
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _learningModule;
@override List<String>? get learningModule {
  final value = _learningModule;
  if (value == null) return null;
  if (_learningModule is EqualUnmodifiableListView) return _learningModule;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of RegisteredClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisteredClassEntityCopyWith<_RegisteredClassEntity> get copyWith => __$RegisteredClassEntityCopyWithImpl<_RegisteredClassEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisteredClassEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisteredClassEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.name, name) || other.name == name)&&(identical(other.quota, quota) || other.quota == quota)&&(identical(other.isFull, isFull) || other.isFull == isFull)&&(identical(other.day, day) || other.day == day)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.ruang, ruang) || other.ruang == ruang)&&const DeepCollectionEquality().equals(other.participants, _participants)&&const DeepCollectionEquality().equals(other.learningModule, _learningModule));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,subject,name,quota,isFull,day,startAt,endAt,ruang,const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_learningModule));
}

@override
String toString() {
    return 'RegisteredClassEntity(id: $id, subject: $subject, name: $name, quota: $quota, isFull: $isFull, day: $day, startAt: $startAt, endAt: $endAt, ruang: $ruang, participants: $participants, learningModule: $learningModule)';
}


}

/// @nodoc
abstract mixin class _$RegisteredClassEntityCopyWith<$Res> implements $RegisteredClassEntityCopyWith<$Res> {
  factory _$RegisteredClassEntityCopyWith(_RegisteredClassEntity value, $Res Function(_RegisteredClassEntity) _then) = __$RegisteredClassEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? subject, String? name, int? quota, bool? isFull, String? day, String? startAt, String? endAt, String? ruang, List<String>? participants, List<String>? learningModule
});




}
/// @nodoc
class __$RegisteredClassEntityCopyWithImpl<$Res>
    implements _$RegisteredClassEntityCopyWith<$Res> {
  __$RegisteredClassEntityCopyWithImpl(this._self, this._then);

  final _RegisteredClassEntity _self;
  final $Res Function(_RegisteredClassEntity) _then;

/// Create a copy of RegisteredClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? subject = freezed,Object? name = freezed,Object? quota = freezed,Object? isFull = freezed,Object? day = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? ruang = freezed,Object? participants = freezed,Object? learningModule = freezed,}) {
  return _then(_RegisteredClassEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as int?,isFull: freezed == isFull ? _self.isFull : isFull // ignore: cast_nullable_to_non_nullable
as bool?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String?,ruang: freezed == ruang ? _self.ruang : ruang // ignore: cast_nullable_to_non_nullable
as String?,participants: freezed == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>?,learningModule: freezed == learningModule ? _self._learningModule : learningModule // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
