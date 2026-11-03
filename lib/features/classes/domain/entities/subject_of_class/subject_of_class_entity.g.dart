// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_of_class_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectOfClassEntity _$SubjectOfClassEntityFromJson(
  Map<String, dynamic> json,
) => _SubjectOfClassEntity(
  id: json['id'] as String?,
  name: json['name'] as String?,
  lecturer: json['lecturer'] as String?,
  classes: (json['classes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SubjectOfClassEntityToJson(
  _SubjectOfClassEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'lecturer': instance.lecturer,
  'classes': instance.classes,
};
