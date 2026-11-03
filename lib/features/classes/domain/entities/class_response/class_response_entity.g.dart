// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClassResponseEntity _$ClassResponseEntityFromJson(Map<String, dynamic> json) =>
    _ClassResponseEntity(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ClassEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassResponseEntityToJson(
  _ClassResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
