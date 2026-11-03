// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduleEntity _$ScheduleEntityFromJson(Map<String, dynamic> json) =>
    _ScheduleEntity(
      day: json['day'] as String?,
      practicums: (json['practicums'] as List<dynamic>?)
          ?.map((e) => PracticumsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleEntityToJson(_ScheduleEntity instance) =>
    <String, dynamic>{'day': instance.day, 'practicums': instance.practicums};
