// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDetailEntity _$UserDetailEntityFromJson(Map<String, dynamic> json) =>
    _UserDetailEntity(
      nim: json['nim'] as String?,
      fullname: json['name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserDetailEntityToJson(_UserDetailEntity instance) =>
    <String, dynamic>{
      'nim': instance.nim,
      'name': instance.fullname,
      'email': instance.email,
    };
