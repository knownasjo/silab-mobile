// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_subject_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SelectedSubjectResponseEntity _$SelectedSubjectResponseEntityFromJson(
  Map<String, dynamic> json,
) => _SelectedSubjectResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => SelectedSubjectEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SelectedSubjectResponseEntityToJson(
  _SelectedSubjectResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
