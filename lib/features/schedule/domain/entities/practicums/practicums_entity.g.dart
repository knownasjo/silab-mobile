// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practicums_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PracticumsEntityImpl _$$PracticumsEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$PracticumsEntityImpl(
      subject_name: json['subject_name'] as String?,
      subject_class: json['subject_class'] as String?,
      session: json['session'] as String?,
      class_id: json['class_id'] as String?,
      room: json['room'] as String?,
      is_assistant: json['is_assistant'] as bool?,
      class_entity: json['class_entity'] == null
          ? null
          : ClassEntity.fromJson(json['class_entity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PracticumsEntityImplToJson(
        _$PracticumsEntityImpl instance) =>
    <String, dynamic>{
      'subject_name': instance.subject_name,
      'subject_class': instance.subject_class,
      'session': instance.session,
      'class_id': instance.class_id,
      'room': instance.room,
      'is_assistant': instance.is_assistant,
      'class_entity': instance.class_entity,
    };
