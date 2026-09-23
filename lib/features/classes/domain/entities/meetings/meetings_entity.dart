import 'package:freezed_annotation/freezed_annotation.dart';

part 'meetings_entity.freezed.dart';
part 'meetings_entity.g.dart';

enum AttendanceStatus { hadir, tidakHadir, belumPresensi }

@freezed
class MeetingsEntity with _$MeetingsEntity {
  const MeetingsEntity._();

  const factory MeetingsEntity({
    final String? id,
    final String? meeting_name,
    final String? submitted_at,
    final bool? is_attended,
    final bool? is_open,
  }) = _MeetingsEntity;

  /// Aturan yang sama dengan web admin: `submitted_at` kosong berarti belum
  /// presensi. `is_attended` dari backend selalu boolean, tidak pernah null.
  AttendanceStatus get attendanceStatus {
    if (submitted_at == null) return AttendanceStatus.belumPresensi;

    return is_attended == true
        ? AttendanceStatus.hadir
        : AttendanceStatus.tidakHadir;
  }

  factory MeetingsEntity.fromJson(Map<String, dynamic> json) =>
      _$MeetingsEntityFromJson(json);
}
