import 'package:freezed_annotation/freezed_annotation.dart';

part 'activation_class_entity.freezed.dart';
part 'activation_class_entity.g.dart';

@freezed
abstract class ActivationClassEntity with _$ActivationClassEntity {
  const factory ActivationClassEntity({
    String? id,
    String? name,
    String? day,
    String? sessionTime,
  }) = _ActivationClassEntity;

  factory ActivationClassEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivationClassEntityFromJson(json);
}
