// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassEntity {

 String? get id; SubjectOfClassEntity? get subject; String? get name; int? get quota; bool? get isFull; String? get day; String? get startAt; String? get endAt; List<String>? get participants; List<String>? get learningModule;
/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassEntityCopyWith<ClassEntity> get copyWith => _$ClassEntityCopyWithImpl<ClassEntity>(this as ClassEntity, _$identity);

  /// Serializes this ClassEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ClassEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.quota, _this.quota) || other.quota == _this.quota)&&(identical(other.isFull, _this.isFull) || other.isFull == _this.isFull)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.startAt, _this.startAt) || other.startAt == _this.startAt)&&(identical(other.endAt, _this.endAt) || other.endAt == _this.endAt)&&const DeepCollectionEquality().equals(other.participants, _this.participants)&&const DeepCollectionEquality().equals(other.learningModule, _this.learningModule));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ClassEntity;
  return Object.hash(runtimeType,_this.id,_this.subject,_this.name,_this.quota,_this.isFull,_this.day,_this.startAt,_this.endAt,const DeepCollectionEquality().hash(_this.participants),const DeepCollectionEquality().hash(_this.learningModule));
}

@override
String toString() {
  final _this = this as ClassEntity;
  return 'ClassEntity(id: ${_this.id}, subject: ${_this.subject}, name: ${_this.name}, quota: ${_this.quota}, isFull: ${_this.isFull}, day: ${_this.day}, startAt: ${_this.startAt}, endAt: ${_this.endAt}, participants: ${_this.participants}, learningModule: ${_this.learningModule})';
}


}

/// @nodoc
abstract mixin class $ClassEntityCopyWith<$Res>  {
  factory $ClassEntityCopyWith(ClassEntity value, $Res Function(ClassEntity) _then) = _$ClassEntityCopyWithImpl;
@useResult
$Res call({
 String? id, SubjectOfClassEntity? subject, String? name, int? quota, bool? isFull, String? day, String? startAt, String? endAt, List<String>? participants, List<String>? learningModule
});


$SubjectOfClassEntityCopyWith<$Res>? get subject;

}
/// @nodoc
class _$ClassEntityCopyWithImpl<$Res>
    implements $ClassEntityCopyWith<$Res> {
  _$ClassEntityCopyWithImpl(this._self, this._then);

  final ClassEntity _self;
  final $Res Function(ClassEntity) _then;

/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? subject = freezed,Object? name = freezed,Object? quota = freezed,Object? isFull = freezed,Object? day = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? participants = freezed,Object? learningModule = freezed,}) {
  return _then(ClassEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as SubjectOfClassEntity?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as int?,isFull: freezed == isFull ? _self.isFull : isFull // ignore: cast_nullable_to_non_nullable
as bool?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String?,participants: freezed == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>?,learningModule: freezed == learningModule ? _self.learningModule : learningModule // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectOfClassEntityCopyWith<$Res>? get subject {
    if (_self.subject == null) {
    return null;
  }

  return $SubjectOfClassEntityCopyWith<$Res>(_self.subject!, (value) {
    return _then(_self.copyWith(subject: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClassEntity].
extension ClassEntityPatterns on ClassEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassEntity value)  $default,){
final _that = this;
switch (_that) {
case _ClassEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ClassEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  SubjectOfClassEntity? subject,  String? name,  int? quota,  bool? isFull,  String? day,  String? startAt,  String? endAt,  List<String>? participants,  List<String>? learningModule)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassEntity() when $default != null:
return $default(_that.id,_that.subject,_that.name,_that.quota,_that.isFull,_that.day,_that.startAt,_that.endAt,_that.participants,_that.learningModule);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  SubjectOfClassEntity? subject,  String? name,  int? quota,  bool? isFull,  String? day,  String? startAt,  String? endAt,  List<String>? participants,  List<String>? learningModule)  $default,) {final _that = this;
switch (_that) {
case _ClassEntity():
return $default(_that.id,_that.subject,_that.name,_that.quota,_that.isFull,_that.day,_that.startAt,_that.endAt,_that.participants,_that.learningModule);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  SubjectOfClassEntity? subject,  String? name,  int? quota,  bool? isFull,  String? day,  String? startAt,  String? endAt,  List<String>? participants,  List<String>? learningModule)?  $default,) {final _that = this;
switch (_that) {
case _ClassEntity() when $default != null:
return $default(_that.id,_that.subject,_that.name,_that.quota,_that.isFull,_that.day,_that.startAt,_that.endAt,_that.participants,_that.learningModule);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassEntity implements ClassEntity {
  const _ClassEntity({this.id, this.subject, this.name, this.quota, this.isFull, this.day, this.startAt, this.endAt,  List<String>? participants,  List<String>? learningModule}): _participants = participants,_learningModule = learningModule;
  factory _ClassEntity.fromJson(Map<String, dynamic> json) => _$ClassEntityFromJson(json);

@override final  String? id;
@override final  SubjectOfClassEntity? subject;
@override final  String? name;
@override final  int? quota;
@override final  bool? isFull;
@override final  String? day;
@override final  String? startAt;
@override final  String? endAt;
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


/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassEntityCopyWith<_ClassEntity> get copyWith => __$ClassEntityCopyWithImpl<_ClassEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.name, name) || other.name == name)&&(identical(other.quota, quota) || other.quota == quota)&&(identical(other.isFull, isFull) || other.isFull == isFull)&&(identical(other.day, day) || other.day == day)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&const DeepCollectionEquality().equals(other.participants, _participants)&&const DeepCollectionEquality().equals(other.learningModule, _learningModule));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,subject,name,quota,isFull,day,startAt,endAt,const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_learningModule));
}

@override
String toString() {
    return 'ClassEntity(id: $id, subject: $subject, name: $name, quota: $quota, isFull: $isFull, day: $day, startAt: $startAt, endAt: $endAt, participants: $participants, learningModule: $learningModule)';
}


}

/// @nodoc
abstract mixin class _$ClassEntityCopyWith<$Res> implements $ClassEntityCopyWith<$Res> {
  factory _$ClassEntityCopyWith(_ClassEntity value, $Res Function(_ClassEntity) _then) = __$ClassEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, SubjectOfClassEntity? subject, String? name, int? quota, bool? isFull, String? day, String? startAt, String? endAt, List<String>? participants, List<String>? learningModule
});


@override $SubjectOfClassEntityCopyWith<$Res>? get subject;

}
/// @nodoc
class __$ClassEntityCopyWithImpl<$Res>
    implements _$ClassEntityCopyWith<$Res> {
  __$ClassEntityCopyWithImpl(this._self, this._then);

  final _ClassEntity _self;
  final $Res Function(_ClassEntity) _then;

/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? subject = freezed,Object? name = freezed,Object? quota = freezed,Object? isFull = freezed,Object? day = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? participants = freezed,Object? learningModule = freezed,}) {
  return _then(_ClassEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as SubjectOfClassEntity?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quota: freezed == quota ? _self.quota : quota // ignore: cast_nullable_to_non_nullable
as int?,isFull: freezed == isFull ? _self.isFull : isFull // ignore: cast_nullable_to_non_nullable
as bool?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String?,participants: freezed == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>?,learningModule: freezed == learningModule ? _self._learningModule : learningModule // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of ClassEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectOfClassEntityCopyWith<$Res>? get subject {
    if (_self.subject == null) {
    return null;
  }

  return $SubjectOfClassEntityCopyWith<$Res>(_self.subject!, (value) {
    return _then(_self.copyWith(subject: value));
  });
}
}

// dart format on
