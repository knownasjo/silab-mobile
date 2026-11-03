// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementResponseEntity _$AnnouncementResponseEntityFromJson(
  Map<String, dynamic> json,
) => _AnnouncementResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : AnnouncementEntity.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AnnouncementResponseEntityToJson(
  _AnnouncementResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
