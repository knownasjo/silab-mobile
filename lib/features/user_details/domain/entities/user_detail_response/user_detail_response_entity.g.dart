// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDetailResponseEntity _$UserDetailResponseEntityFromJson(
  Map<String, dynamic> json,
) => _UserDetailResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : UserDetailEntity.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserDetailResponseEntityToJson(
  _UserDetailResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
