import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';

part 'practicums_entity.freezed.dart';
part 'practicums_entity.g.dart';

@freezed
class PracticumsEntity with _$PracticumsEntity {
  const factory PracticumsEntity({
    final String? subjectName,
    final String? subjectClass,
    final String? session,
    final String? classId,
    final String? room,
    final bool? isAssistant,
    final ClassEntity? classEntity,
  }) = _PracticumsEntity;

  factory PracticumsEntity.fromJson(Map<String, dynamic> json) =>
      _$PracticumsEntityFromJson(json);
}
