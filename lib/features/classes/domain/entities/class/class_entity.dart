import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/classes/domain/entities/subject_of_class/subject_of_class_entity.dart';

part 'class_entity.freezed.dart';
part 'class_entity.g.dart';

@freezed
abstract class ClassEntity with _$ClassEntity {
  const factory ClassEntity({
    String? id,
    SubjectOfClassEntity? subject,
    String? name,
    int? quota,
    bool? isFull,
    String? day,
    String? startAt,
    String? endAt,
    List<String>? participants,
    List<String>? learningModule,
  }) = _ClassEntity;

  factory ClassEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassEntityFromJson(json);
}
