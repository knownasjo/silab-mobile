// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_class_option_by_paid_subject_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserClassOptionByPaidSubjectResponseEntity
_$UserClassOptionByPaidSubjectResponseEntityFromJson(
  Map<String, dynamic> json,
) => _UserClassOptionByPaidSubjectResponseEntity(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map(
        (e) => UserClassOptionByPaidSubjectEntity.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$UserClassOptionByPaidSubjectResponseEntityToJson(
  _UserClassOptionByPaidSubjectResponseEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
