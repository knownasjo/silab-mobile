import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_participants_entity.freezed.dart';
part 'class_participants_entity.g.dart';

@freezed
abstract class ClassParticipantsEntity with _$ClassParticipantsEntity {
  const factory ClassParticipantsEntity({
    String? id,
    String? email,
    String? fullname,
    String? nim,
    List<String>? role,
    bool? paid,
  }) = _ClassParticipantsEntity;

  factory ClassParticipantsEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassParticipantsEntityFromJson(json);
}
