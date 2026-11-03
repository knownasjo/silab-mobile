// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_selected_subject_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddSelectedSubjectResponseEntity _$AddSelectedSubjectResponseEntityFromJson(
  Map<String, dynamic> json,
) => _AddSelectedSubjectResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : AddSubjectSubjectsEntity.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AddSelectedSubjectResponseEntityToJson(
  _AddSelectedSubjectResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
