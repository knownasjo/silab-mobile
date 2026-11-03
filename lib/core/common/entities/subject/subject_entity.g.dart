// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectEntity _$SubjectEntityFromJson(Map<String, dynamic> json) =>
    _SubjectEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      lecturer: json['lecturer'] as String?,
      semester: (json['semester'] as num?)?.toInt(),
      classes: (json['classes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SubjectEntityToJson(_SubjectEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lecturer': instance.lecturer,
      'semester': instance.semester,
      'classes': instance.classes,
    };
