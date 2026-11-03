import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';

part 'practicums_entity.freezed.dart';
part 'practicums_entity.g.dart';

@freezed
abstract class PracticumsEntity with _$PracticumsEntity {
  const factory PracticumsEntity({
    String? subjectName,
    String? subjectClass,
    String? session,
    String? classId,
    String? room,
    bool? isAssistant,
    ClassEntity? classEntity,
  }) = _PracticumsEntity;

  factory PracticumsEntity.fromJson(Map<String, dynamic> json) =>
      _$PracticumsEntityFromJson(json);
}
