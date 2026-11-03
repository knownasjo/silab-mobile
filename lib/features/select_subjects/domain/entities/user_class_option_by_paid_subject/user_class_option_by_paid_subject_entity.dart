import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_class_option_by_paid_subject_entity.freezed.dart';
part 'user_class_option_by_paid_subject_entity.g.dart';

@freezed
abstract class UserClassOptionByPaidSubjectEntity
    with _$UserClassOptionByPaidSubjectEntity {
  const factory UserClassOptionByPaidSubjectEntity({
    @JsonKey(name: 'id') String? classId,
    String? subjectName,
    String? subjectClass,
    String? semester,
    String? sessionTime,
    int? quota,
    int? registeredStudents,
    String? day,
  }) = _UserClassOptionByPaidSubjectEntity;

  factory UserClassOptionByPaidSubjectEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$UserClassOptionByPaidSubjectEntityFromJson(json);
}
