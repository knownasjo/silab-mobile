// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementListResponseEntity _$AnnouncementListResponseEntityFromJson(
  Map<String, dynamic> json,
) => _AnnouncementListResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => AnnouncementEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnnouncementListResponseEntityToJson(
  _AnnouncementListResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
