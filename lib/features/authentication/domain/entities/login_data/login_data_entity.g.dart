// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginDataEntity _$LoginDataEntityFromJson(Map<String, dynamic> json) =>
    _LoginDataEntity(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$LoginDataEntityToJson(_LoginDataEntity instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
