// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectedSubjectEntityImpl _$$SelectedSubjectEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$SelectedSubjectEntityImpl(
      activationId: json['id'] as String?,
      status: json['status'] as bool?,
      createdAt: json['createdAt'] as String?,
      subjectId: json['subjectId'] as String?,
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) =>
              SelectedSubjectSubjectsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      registeredClass: json['registeredClass'] == null
          ? null
          : ActivationClassEntity.fromJson(
              json['registeredClass'] as Map<String, dynamic>),
      availableClasses: (json['availableClasses'] as List<dynamic>?)
          ?.map(
              (e) => ActivationClassEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SelectedSubjectEntityImplToJson(
        _$SelectedSubjectEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.activationId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'subjectId': instance.subjectId,
      'subjects': instance.subjects,
      'registeredClass': instance.registeredClass,
      'availableClasses': instance.availableClasses,
    };
