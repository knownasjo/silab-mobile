// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_class_option_by_paid_subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserClassOptionByPaidSubjectEntity
_$UserClassOptionByPaidSubjectEntityFromJson(Map<String, dynamic> json) =>
    _UserClassOptionByPaidSubjectEntity(
      classId: json['id'] as String?,
      subjectName: json['subjectName'] as String?,
      subjectClass: json['subjectClass'] as String?,
      semester: json['semester'] as String?,
      sessionTime: json['sessionTime'] as String?,
      quota: (json['quota'] as num?)?.toInt(),
      registeredStudents: (json['registeredStudents'] as num?)?.toInt(),
      day: json['day'] as String?,
    );

Map<String, dynamic> _$UserClassOptionByPaidSubjectEntityToJson(
  _UserClassOptionByPaidSubjectEntity instance,
) => <String, dynamic>{
  'id': instance.classId,
  'subjectName': instance.subjectName,
  'subjectClass': instance.subjectClass,
  'semester': instance.semester,
  'sessionTime': instance.sessionTime,
  'quota': instance.quota,
  'registeredStudents': instance.registeredStudents,
  'day': instance.day,
};
