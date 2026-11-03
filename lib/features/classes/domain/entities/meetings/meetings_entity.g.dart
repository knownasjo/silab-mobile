// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingsEntity _$MeetingsEntityFromJson(Map<String, dynamic> json) =>
    _MeetingsEntity(
      id: json['id'] as String?,
      meetingName: json['meetingName'] as String?,
      submittedAt: json['submittedAt'] as String?,
      isAttended: json['isAttended'] as bool?,
      isOpen: json['isOpen'] as bool?,
    );

Map<String, dynamic> _$MeetingsEntityToJson(_MeetingsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meetingName': instance.meetingName,
      'submittedAt': instance.submittedAt,
      'isAttended': instance.isAttended,
      'isOpen': instance.isOpen,
    };
