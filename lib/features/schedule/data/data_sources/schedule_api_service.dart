import 'package:collection/collection.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';
import 'package:silab/core/helpers/day_formatter.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/schedule/domain/entities/practicums/practicums_entity.dart';
import 'package:silab/features/schedule/domain/entities/schedule/schedule_entity.dart';
import 'package:silab/features/user_details/domain/entities/assisted_class/assisted_class_entity.dart';

class ScheduleApiService {
  final ApiClient _apiClient;

  const ScheduleApiService(this._apiClient);

  Future<List<ScheduleEntity>> getUserSchedule() async {
    final responses = await Future.wait([
      _apiClient.get('/class/me'),
      _apiClient.get('/class'),
    ]);

    final classes = (responses[0]['data'] as List<dynamic>? ?? [])
        .map((item) => ClassEntity.fromJson(item as Map<String, dynamic>))
        .toList();
    final assistedData = responses[1]['data'];
    final assistedClasses = assistedData is List
        ? assistedData
            .whereType<Map<String, dynamic>>()
            .map(AssistedClassEntity.fromJson)
            .toList()
        : const <AssistedClassEntity>[];

    final practicums = [
      for (final c in classes)
        (
          day: c.day,
          practicum: PracticumsEntity(
            class_id: c.id,
            subject_name: c.subject_name,
            subject_class: c.subject_class,
            session: c.session_time,
            room: c.room,
            class_entity: c,
          ),
        ),
      for (final a in assistedClasses)
        (
          day: a.day,
          practicum: PracticumsEntity(
            class_id: a.id,
            subject_name: a.subjectName,
            subject_class: a.name,
            session: '${a.startAt} - ${a.endAt}',
            room: a.room,
            is_assistant: true,
          ),
        ),
    ];

    final practicumsByDay = groupBy(practicums, (item) => item.day);

    return weekdayOrder
        .where(practicumsByDay.containsKey)
        .map(
          (day) => ScheduleEntity(
            day: formatDay(day),
            practicums: practicumsByDay[day]!
                .map((item) => item.practicum)
                .sorted((a, b) => (a.session ?? '').compareTo(b.session ?? '')),
          ),
        )
        .toList();
  }
}
