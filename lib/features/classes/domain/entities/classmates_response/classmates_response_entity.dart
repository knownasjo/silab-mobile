import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/classes/domain/entities/classmate/classmate_entity.dart';

part 'classmates_response_entity.freezed.dart';
part 'classmates_response_entity.g.dart';

@freezed
abstract class ClassmatesResponseEntity with _$ClassmatesResponseEntity {
  const factory ClassmatesResponseEntity({
    bool? status,
    String? message,
    List<ClassmateEntity>? data,
  }) = _ClassmatesResponseEntity;

  factory ClassmatesResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassmatesResponseEntityFromJson(json);
}
