// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectedSubjectEntityImpl _$$SelectedSubjectEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$SelectedSubjectEntityImpl(
      activation_id: json['id'] as String?,
      status: json['status'] as bool?,
      created_at: json['created_at'] as String?,
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) =>
              SelectedSubjectSubjectsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      registered_class: json['registered_class'] == null
          ? null
          : ActivationClassEntity.fromJson(
              json['registered_class'] as Map<String, dynamic>),
      available_classes: (json['available_classes'] as List<dynamic>?)
          ?.map(
              (e) => ActivationClassEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SelectedSubjectEntityImplToJson(
        _$SelectedSubjectEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.activation_id,
      'status': instance.status,
      'created_at': instance.created_at,
      'subjects': instance.subjects,
      'registered_class': instance.registered_class,
      'available_classes': instance.available_classes,
    };
