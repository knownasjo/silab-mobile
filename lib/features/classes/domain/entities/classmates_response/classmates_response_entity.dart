import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/classes/domain/entities/classmate/classmate_entity.dart';

part 'classmates_response_entity.freezed.dart';
part 'classmates_response_entity.g.dart';

@freezed
class ClassmatesResponseEntity with _$ClassmatesResponseEntity {
  const factory ClassmatesResponseEntity({
    final bool? status,
    final String? message,
    final List<ClassmateEntity>? data,
  }) = _ClassmatesResponseEntity;

  factory ClassmatesResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassmatesResponseEntityFromJson(json);
}
