// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingsResponseEntity _$MeetingsResponseEntityFromJson(
  Map<String, dynamic> json,
) => _MeetingsResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => MeetingsEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MeetingsResponseEntityToJson(
  _MeetingsResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
