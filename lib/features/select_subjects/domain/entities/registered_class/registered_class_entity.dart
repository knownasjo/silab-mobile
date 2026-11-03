import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_class_entity.freezed.dart';
part 'registered_class_entity.g.dart';

@freezed
abstract class RegisteredClassEntity with _$RegisteredClassEntity {
  const factory RegisteredClassEntity({
    String? id,
    String? subject,
    String? name,
    int? quota,
    bool? isFull,
    String? day,
    String? startAt,
    String? endAt,
    String? ruang,
    List<String>? participants,
    List<String>? learningModule,
  }) = _RegisteredClassEntity;

  factory RegisteredClassEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisteredClassEntityFromJson(json);
}
