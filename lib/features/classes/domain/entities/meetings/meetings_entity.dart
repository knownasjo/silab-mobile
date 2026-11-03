import 'package:freezed_annotation/freezed_annotation.dart';

part 'meetings_entity.freezed.dart';
part 'meetings_entity.g.dart';

enum AttendanceStatus { hadir, tidakHadir, belumPresensi }

@freezed
abstract class MeetingsEntity with _$MeetingsEntity {
  const MeetingsEntity._();

  const factory MeetingsEntity({
    String? id,
    String? meetingName,
    String? submittedAt,
    bool? isAttended,
    bool? isOpen,
  }) = _MeetingsEntity;

  AttendanceStatus get attendanceStatus {
    if (submittedAt == null) return AttendanceStatus.belumPresensi;

    return isAttended == true
        ? AttendanceStatus.hadir
        : AttendanceStatus.tidakHadir;
  }

  factory MeetingsEntity.fromJson(Map<String, dynamic> json) =>
      _$MeetingsEntityFromJson(json);
}
