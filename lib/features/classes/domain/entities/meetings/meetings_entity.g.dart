// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetingsEntityImpl _$$MeetingsEntityImplFromJson(Map<String, dynamic> json) =>
    _$MeetingsEntityImpl(
      id: json['id'] as String?,
      meetingName: json['meetingName'] as String?,
      submittedAt: json['submittedAt'] as String?,
      isAttended: json['isAttended'] as bool?,
      isOpen: json['isOpen'] as bool?,
    );

Map<String, dynamic> _$$MeetingsEntityImplToJson(
        _$MeetingsEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meetingName': instance.meetingName,
      'submittedAt': instance.submittedAt,
      'isAttended': instance.isAttended,
      'isOpen': instance.isOpen,
    };
