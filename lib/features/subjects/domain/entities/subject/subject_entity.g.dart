// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectEntity _$SubjectEntityFromJson(Map<String, dynamic> json) =>
    _SubjectEntity(
      id: json['id'] as String?,
      subjectName: json['subjectName'] as String?,
      subjectCode: json['subjectCode'] as String?,
      semester: json['semester'] as String?,
    );

Map<String, dynamic> _$SubjectEntityToJson(_SubjectEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectName': instance.subjectName,
      'subjectCode': instance.subjectCode,
      'semester': instance.semester,
    };
