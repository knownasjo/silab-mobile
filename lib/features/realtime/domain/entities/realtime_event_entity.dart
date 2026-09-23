import 'package:equatable/equatable.dart';

class RealtimeEventEntity extends Equatable {
  final String type;
  final String? classId;
  final String? meetingId;
  final String? announcementId;
  final String? action;

  const RealtimeEventEntity({
    required this.type,
    this.classId,
    this.meetingId,
    this.announcementId,
    this.action,
  });

  factory RealtimeEventEntity.fromJson(
    String type,
    Map<String, dynamic> json,
  ) =>
      RealtimeEventEntity(
        type: type,
        classId: _readString(json['class_id']),
        meetingId: _readString(json['meeting_id']),
        announcementId: _readString(json['announcement_id']),
        action: _readString(json['action']),
      );

  static String? _readString(Object? value) => value is String ? value : null;

  @override
  List<Object?> get props => [type, classId, meetingId, announcementId, action];
}
