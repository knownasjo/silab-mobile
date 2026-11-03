// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementEntity _$AnnouncementEntityFromJson(Map<String, dynamic> json) =>
    _AnnouncementEntity(
      id: json['id'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      body: json['body'] as String?,
      createdAt: json['createdAt'] as String?,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$AnnouncementEntityToJson(_AnnouncementEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'author': instance.author,
    };
