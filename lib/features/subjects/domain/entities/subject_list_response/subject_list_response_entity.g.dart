// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectListResponseEntity _$SubjectListResponseEntityFromJson(
  Map<String, dynamic> json,
) => _SubjectListResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => SubjectEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubjectListResponseEntityToJson(
  _SubjectListResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
