// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classmates_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassmatesResponseEntityImpl _$$ClassmatesResponseEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ClassmatesResponseEntityImpl(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ClassmateEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ClassmatesResponseEntityImplToJson(
        _$ClassmatesResponseEntityImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
