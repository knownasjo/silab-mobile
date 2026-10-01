import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';

part 'practicums_entity.freezed.dart';
part 'practicums_entity.g.dart';

@freezed
class PracticumsEntity with _$PracticumsEntity {
  const factory PracticumsEntity({
    final String? subject_name,
    final String? subject_class,
    final String? session,
    final String? class_id,
    final String? room,
    final bool? is_assistant,
    final ClassEntity? class_entity,
  }) = _PracticumsEntity;

  factory PracticumsEntity.fromJson(Map<String, dynamic> json) =>
      _$PracticumsEntityFromJson(json);
}
