// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnnouncementEntity {

 String? get id; String? get title; String? get type; String? get body; String? get createdAt; String? get author;
/// Create a copy of AnnouncementEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementEntityCopyWith<AnnouncementEntity> get copyWith => _$AnnouncementEntityCopyWithImpl<AnnouncementEntity>(this as AnnouncementEntity, _$identity);

  /// Serializes this AnnouncementEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnnouncementEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.author, _this.author) || other.author == _this.author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnnouncementEntity;
  return Object.hash(runtimeType,_this.id,_this.title,_this.type,_this.body,_this.createdAt,_this.author);
}

@override
String toString() {
  final _this = this as AnnouncementEntity;
  return 'AnnouncementEntity(id: ${_this.id}, title: ${_this.title}, type: ${_this.type}, body: ${_this.body}, createdAt: ${_this.createdAt}, author: ${_this.author})';
}


}

/// @nodoc
abstract mixin class $AnnouncementEntityCopyWith<$Res>  {
  factory $AnnouncementEntityCopyWith(AnnouncementEntity value, $Res Function(AnnouncementEntity) _then) = _$AnnouncementEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? title, String? type, String? body, String? createdAt, String? author
});




}
/// @nodoc
class _$AnnouncementEntityCopyWithImpl<$Res>
    implements $AnnouncementEntityCopyWith<$Res> {
  _$AnnouncementEntityCopyWithImpl(this._self, this._then);

  final AnnouncementEntity _self;
  final $Res Function(AnnouncementEntity) _then;

/// Create a copy of AnnouncementEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? type = freezed,Object? body = freezed,Object? createdAt = freezed,Object? author = freezed,}) {
  return _then(AnnouncementEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementEntity].
extension AnnouncementEntityPatterns on AnnouncementEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementEntity value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? title,  String? type,  String? body,  String? createdAt,  String? author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementEntity() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.body,_that.createdAt,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? title,  String? type,  String? body,  String? createdAt,  String? author)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementEntity():
return $default(_that.id,_that.title,_that.type,_that.body,_that.createdAt,_that.author);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? title,  String? type,  String? body,  String? createdAt,  String? author)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementEntity() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.body,_that.createdAt,_that.author);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementEntity implements AnnouncementEntity {
  const _AnnouncementEntity({this.id, this.title, this.type, this.body, this.createdAt, this.author});
  factory _AnnouncementEntity.fromJson(Map<String, dynamic> json) => _$AnnouncementEntityFromJson(json);

@override final  String? id;
@override final  String? title;
@override final  String? type;
@override final  String? body;
@override final  String? createdAt;
@override final  String? author;

/// Create a copy of AnnouncementEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementEntityCopyWith<_AnnouncementEntity> get copyWith => __$AnnouncementEntityCopyWithImpl<_AnnouncementEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,type,body,createdAt,author);
}

@override
String toString() {
    return 'AnnouncementEntity(id: $id, title: $title, type: $type, body: $body, createdAt: $createdAt, author: $author)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementEntityCopyWith<$Res> implements $AnnouncementEntityCopyWith<$Res> {
  factory _$AnnouncementEntityCopyWith(_AnnouncementEntity value, $Res Function(_AnnouncementEntity) _then) = __$AnnouncementEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? title, String? type, String? body, String? createdAt, String? author
});




}
/// @nodoc
class __$AnnouncementEntityCopyWithImpl<$Res>
    implements _$AnnouncementEntityCopyWith<$Res> {
  __$AnnouncementEntityCopyWithImpl(this._self, this._then);

  final _AnnouncementEntity _self;
  final $Res Function(_AnnouncementEntity) _then;

/// Create a copy of AnnouncementEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? type = freezed,Object? body = freezed,Object? createdAt = freezed,Object? author = freezed,}) {
  return _then(_AnnouncementEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
