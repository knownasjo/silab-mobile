import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/select_subjects/domain/entities/activation_class/activation_class_entity.dart';
import 'package:silab/features/select_subjects/domain/entities/subject/selected_subject_subjects.dart';

part 'selected_subject_entity.freezed.dart';
part 'selected_subject_entity.g.dart';

@freezed
class SelectedSubjectEntity with _$SelectedSubjectEntity {
  const factory SelectedSubjectEntity({
    @JsonKey(name: 'id') final String? activationId,
    final bool? status,
    final String? createdAt,
    final String? subjectId,
    final List<SelectedSubjectSubjectsEntity>? subjects,
    final ActivationClassEntity? registeredClass,
    final List<ActivationClassEntity>? availableClasses,
  }) = _SelectedSubjectEntity;

  factory SelectedSubjectEntity.fromJson(Map<String, dynamic> json) =>
      _$SelectedSubjectEntityFromJson(json);
}
