// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activation_class_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivationClassEntity _$ActivationClassEntityFromJson(
  Map<String, dynamic> json,
) => _ActivationClassEntity(
  id: json['id'] as String?,
  name: json['name'] as String?,
  day: json['day'] as String?,
  sessionTime: json['sessionTime'] as String?,
);

Map<String, dynamic> _$ActivationClassEntityToJson(
  _ActivationClassEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'day': instance.day,
  'sessionTime': instance.sessionTime,
};
