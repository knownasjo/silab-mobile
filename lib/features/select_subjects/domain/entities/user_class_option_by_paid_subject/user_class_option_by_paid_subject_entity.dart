import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_class_option_by_paid_subject_entity.freezed.dart';
part 'user_class_option_by_paid_subject_entity.g.dart';

@freezed
class UserClassOptionByPaidSubjectEntity
    with _$UserClassOptionByPaidSubjectEntity {
  const factory UserClassOptionByPaidSubjectEntity({
    @JsonKey(name: 'id') final String? classId,
    final String? subjectName,
    final String? subjectClass,
    final String? semester,
    final String? sessionTime,
    final int? quota,
    final int? registeredStudents,
    final String? day,
  }) = _UserClassOptionByPaidSubjectEntity;

  factory UserClassOptionByPaidSubjectEntity.fromJson(
          Map<String, dynamic> json) =>
      _$UserClassOptionByPaidSubjectEntityFromJson(json);
}
