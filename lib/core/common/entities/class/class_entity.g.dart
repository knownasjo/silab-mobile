// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassEntityImpl _$$ClassEntityImplFromJson(Map<String, dynamic> json) =>
    _$ClassEntityImpl(
      id: json['id'] as String?,
      subjectName: json['subjectName'] as String?,
      subjectClass: json['subjectClass'] as String?,
      day: json['day'] as String?,
      lecturer: json['lecturer'] as String?,
      sessionTime: json['sessionTime'] as String?,
      room: json['room'] as String?,
    );

Map<String, dynamic> _$$ClassEntityImplToJson(_$ClassEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectName': instance.subjectName,
      'subjectClass': instance.subjectClass,
      'day': instance.day,
      'lecturer': instance.lecturer,
      'sessionTime': instance.sessionTime,
      'room': instance.room,
    };
