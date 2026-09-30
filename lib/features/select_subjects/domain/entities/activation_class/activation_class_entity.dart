import 'package:freezed_annotation/freezed_annotation.dart';

part 'activation_class_entity.freezed.dart';
part 'activation_class_entity.g.dart';

@freezed
class ActivationClassEntity with _$ActivationClassEntity {
  const factory ActivationClassEntity({
    final String? id,
    final String? name,
    final String? day,
    final String? session_time,
  }) = _ActivationClassEntity;

  factory ActivationClassEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivationClassEntityFromJson(json);
}
