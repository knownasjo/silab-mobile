import 'package:freezed_annotation/freezed_annotation.dart';

part 'classmate_entity.freezed.dart';
part 'classmate_entity.g.dart';

@freezed
abstract class ClassmateEntity with _$ClassmateEntity {
  const factory ClassmateEntity({String? name, bool? isMe}) = _ClassmateEntity;

  factory ClassmateEntity.fromJson(Map<String, dynamic> json) =>
      _$ClassmateEntityFromJson(json);
}
