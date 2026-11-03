import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_entity.freezed.dart';
part 'announcement_entity.g.dart';

@freezed
abstract class AnnouncementEntity with _$AnnouncementEntity {
  const factory AnnouncementEntity({
    String? id,
    String? title,
    String? type,
    String? body,
    String? createdAt,
    String? author,
  }) = _AnnouncementEntity;

  factory AnnouncementEntity.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementEntityFromJson(json);
}
