// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubjectEntityImpl _$$SubjectEntityImplFromJson(Map<String, dynamic> json) =>
    _$SubjectEntityImpl(
      id: json['id'] as String?,
      subjectName: json['subjectName'] as String?,
      subjectCode: json['subjectCode'] as String?,
      semester: json['semester'] as String?,
    );

Map<String, dynamic> _$$SubjectEntityImplToJson(_$SubjectEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectName': instance.subjectName,
      'subjectCode': instance.subjectCode,
      'semester': instance.semester,
    };
