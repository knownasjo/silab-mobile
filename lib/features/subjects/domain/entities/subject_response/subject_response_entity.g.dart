// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectResponseEntity _$SubjectResponseEntityFromJson(
  Map<String, dynamic> json,
) => _SubjectResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SubjectEntity.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SubjectResponseEntityToJson(
  _SubjectResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
