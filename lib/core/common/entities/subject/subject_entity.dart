import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_entity.freezed.dart';
part 'subject_entity.g.dart';

@freezed
abstract class SubjectEntity with _$SubjectEntity {
  const factory SubjectEntity({
    String? id,
    String? name,
    String? lecturer,
    int? semester,
    List<String>? classes,
  }) = _SubjectEntity;

  factory SubjectEntity.fromJson(Map<String, dynamic> json) =>
      _$SubjectEntityFromJson(json);
}
