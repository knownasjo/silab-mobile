import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_of_class_entity.freezed.dart';
part 'subject_of_class_entity.g.dart';

@freezed
abstract class SubjectOfClassEntity with _$SubjectOfClassEntity {
  const factory SubjectOfClassEntity({
    String? id,
    String? name,
    String? lecturer,
    List<String>? classes,
  }) = _SubjectOfClassEntity;

  factory SubjectOfClassEntity.fromJson(Map<String, dynamic> json) =>
      _$SubjectOfClassEntityFromJson(json);
}
