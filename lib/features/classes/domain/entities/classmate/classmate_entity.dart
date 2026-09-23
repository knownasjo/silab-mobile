import 'package:freezed_annotation/freezed_annotation.dart';

part 'classmate_entity.freezed.dart';
part 'classmate_entity.g.dart';

@freezed
class ClassmateEntity with _$ClassmateEntity {
  const factory ClassmateEntity({
    final String? name,
    final bool? is_me,
  }) = _ClassmateEntity;

  factory ClassmateEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassmateEntityFromJson(json);
}
