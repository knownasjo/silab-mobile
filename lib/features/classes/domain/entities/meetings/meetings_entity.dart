import 'package:freezed_annotation/freezed_annotation.dart';

part 'meetings_entity.freezed.dart';
part 'meetings_entity.g.dart';

enum AttendanceStatus { hadir, tidakHadir, belumPresensi }

@freezed
class MeetingsEntity with _$MeetingsEntity {
  const MeetingsEntity._();

  const factory MeetingsEntity({
    final String? id,
    final String? meetingName,
    final String? submittedAt,
    final bool? isAttended,
    final bool? isOpen,
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
