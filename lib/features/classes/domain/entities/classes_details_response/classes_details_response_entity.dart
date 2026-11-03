import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/classes/domain/entities/class/class_entity.dart';

part 'classes_details_response_entity.freezed.dart';
part 'classes_details_response_entity.g.dart';

@freezed
abstract class ClassesDetailsResponseEntity with _$ClassesDetailsResponseEntity {
  const factory ClassesDetailsResponseEntity({
    int? status,
    String? message,
    List<ClassEntity>? data,
  }) = _ClassesDetailsResponseEntity;

  factory ClassesDetailsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassesDetailsResponseEntityFromJson(json);
}
