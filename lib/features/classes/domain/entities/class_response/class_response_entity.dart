import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/classes/domain/entities/class/class_entity.dart';

part 'class_response_entity.freezed.dart';
part 'class_response_entity.g.dart';

@freezed
abstract class ClassResponseEntity with _$ClassResponseEntity {
  const factory ClassResponseEntity({
    int? status,
    String? message,
    ClassEntity? data,
  }) = _ClassResponseEntity;

  factory ClassResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassResponseEntityFromJson(json);
}
