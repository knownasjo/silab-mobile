import 'package:equatable/equatable.dart';

class AssistedClassEntity extends Equatable {
  final String id;
  final String name;
  final String subjectName;
  final String? day;
  final String? startAt;
  final String? endAt;
  final String? room;

  const AssistedClassEntity({
    required this.id,
    required this.name,
    required this.subjectName,
    this.day,
    this.startAt,
    this.endAt,
    this.room,
  });

  factory AssistedClassEntity.fromJson(Map<String, dynamic> json) =>
      AssistedClassEntity(
        id: _readString(json['id']) ?? '',
        name: _readString(json['name']) ?? '-',
        subjectName: _readString(json['subject_name']) ?? '-',
        day: _readString(json['day']),
        startAt: _readString(json['startAt']),
        endAt: _readString(json['endAt']),
        room: _readString(json['room']),
      );

  static String? _readString(Object? value) => value is String ? value : null;

  @override
  List<Object?> get props => [id, name, subjectName, day, startAt, endAt, room];
}
