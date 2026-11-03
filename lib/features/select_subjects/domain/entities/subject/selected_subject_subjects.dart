import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_subject_subjects.freezed.dart';
part 'selected_subject_subjects.g.dart';

@freezed
abstract class SelectedSubjectSubjectsEntity
    with _$SelectedSubjectSubjectsEntity {
  const factory SelectedSubjectSubjectsEntity({
    String? subjectName,
    String? semester,
  }) = _SelectedSubjectSubjectsEntity;

  factory SelectedSubjectSubjectsEntity.fromJson(Map<String, dynamic> json) =>
      _$SelectedSubjectSubjectsEntityFromJson(json);
}
