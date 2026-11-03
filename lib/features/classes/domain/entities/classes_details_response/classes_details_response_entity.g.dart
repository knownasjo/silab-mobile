// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_details_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClassesDetailsResponseEntity _$ClassesDetailsResponseEntityFromJson(
  Map<String, dynamic> json,
) => _ClassesDetailsResponseEntity(
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ClassEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ClassesDetailsResponseEntityToJson(
  _ClassesDetailsResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
