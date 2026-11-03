import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_entity.freezed.dart';
part 'class_entity.g.dart';

@freezed
abstract class ClassEntity with _$ClassEntity {
  const factory ClassEntity({
    String? id,
    String? subjectName,
    String? subjectClass,
    String? day,
    String? lecturer,
    String? sessionTime,
    String? room,
  }) = _ClassEntity;

  factory ClassEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassEntityFromJson(json);
}
