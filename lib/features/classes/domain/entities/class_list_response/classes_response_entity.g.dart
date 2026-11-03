// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClassesResponseEntity _$ClassesResponseEntityFromJson(
  Map<String, dynamic> json,
) => _ClassesResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ClassEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ClassesResponseEntityToJson(
  _ClassesResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
