import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/subjects/domain/entities/subject/subject_entity.dart';

part 'subject_list_response_entity.freezed.dart';
part 'subject_list_response_entity.g.dart';

@freezed
abstract class SubjectListResponseEntity with _$SubjectListResponseEntity {
  const factory SubjectListResponseEntity({
    bool? status,
    String? message,
    List<SubjectEntity>? data,
  }) = _SubjectListResponseEntity;

  factory SubjectListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SubjectListResponseEntityFromJson(json);
}
