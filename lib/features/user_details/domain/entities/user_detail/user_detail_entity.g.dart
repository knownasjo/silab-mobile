// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDetailEntityImpl _$$UserDetailEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$UserDetailEntityImpl(
      nim: json['nim'] as String?,
      fullname: json['name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$UserDetailEntityImplToJson(
        _$UserDetailEntityImpl instance) =>
    <String, dynamic>{
      'nim': instance.nim,
      'name': instance.fullname,
      'email': instance.email,
    };
