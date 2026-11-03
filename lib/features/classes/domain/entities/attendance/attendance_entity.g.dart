// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceEntity _$AttendanceEntityFromJson(Map<String, dynamic> json) =>
    _AttendanceEntity(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AttendanceEntityToJson(_AttendanceEntity instance) =>
    <String, dynamic>{'status': instance.status, 'message': instance.message};
