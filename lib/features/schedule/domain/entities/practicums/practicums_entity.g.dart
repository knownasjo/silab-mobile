// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practicums_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PracticumsEntityImpl _$$PracticumsEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$PracticumsEntityImpl(
      subjectName: json['subjectName'] as String?,
      subjectClass: json['subjectClass'] as String?,
      session: json['session'] as String?,
      classId: json['classId'] as String?,
      room: json['room'] as String?,
      isAssistant: json['isAssistant'] as bool?,
      classEntity: json['classEntity'] == null
          ? null
          : ClassEntity.fromJson(json['classEntity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PracticumsEntityImplToJson(
        _$PracticumsEntityImpl instance) =>
    <String, dynamic>{
      'subjectName': instance.subjectName,
      'subjectClass': instance.subjectClass,
      'session': instance.session,
      'classId': instance.classId,
      'room': instance.room,
      'isAssistant': instance.isAssistant,
      'classEntity': instance.classEntity,
    };
