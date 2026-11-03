import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';

part 'announcement_response_entity.freezed.dart';
part 'announcement_response_entity.g.dart';

@freezed
abstract class AnnouncementResponseEntity with _$AnnouncementResponseEntity {
  const factory AnnouncementResponseEntity({
    bool? status,
    String? message,
    AnnouncementEntity? data,
  }) = _AnnouncementResponseEntity;

  factory AnnouncementResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementResponseEntityFromJson(json);
}
