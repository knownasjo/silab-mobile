import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/select_subjects/domain/entities/activation_class/activation_class_entity.dart';
import 'package:silab/features/select_subjects/domain/entities/subject/selected_subject_subjects.dart';

part 'selected_subject_entity.freezed.dart';
part 'selected_subject_entity.g.dart';

@freezed
abstract class SelectedSubjectEntity with _$SelectedSubjectEntity {
  const factory SelectedSubjectEntity({
    @JsonKey(name: 'id') String? activationId,
    bool? status,
    String? createdAt,
    String? subjectId,
    List<SelectedSubjectSubjectsEntity>? subjects,
    ActivationClassEntity? registeredClass,
    List<ActivationClassEntity>? availableClasses,
  }) = _SelectedSubjectEntity;

  factory SelectedSubjectEntity.fromJson(Map<String, dynamic> json) =>
      _$SelectedSubjectEntityFromJson(json);
}
