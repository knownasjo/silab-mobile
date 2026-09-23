import 'package:collection/collection.dart';
import 'package:silab/core/common/entities/class/class_entity.dart';
import 'package:silab/core/helpers/day_formatter.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/schedule/domain/entities/practicums/practicums_entity.dart';
import 'package:silab/features/schedule/domain/entities/schedule/schedule_entity.dart';

class ScheduleApiService {
  final ApiClient _apiClient;

  const ScheduleApiService(this._apiClient);

  /// Jadwal disusun dari kelas yang diikuti mahasiswa, dikelompokkan per hari.
  Future<List<ScheduleEntity>> getUserSchedule() async {
    final json = await _apiClient.get('/class/me');
    final classes = (json['data'] as List<dynamic>? ?? [])
        .map((item) => ClassEntity.fromJson(item as Map<String, dynamic>))
        .toList();

    final classesByDay = groupBy(classes, (ClassEntity c) => c.day);

    return weekdayOrder
        .where(classesByDay.containsKey)
        .map(
          (day) => ScheduleEntity(
            day: formatDay(day),
            practicums: classesByDay[day]!
                .map(
                  (c) => PracticumsEntity(
                    subject_name: c.subject_name,
                    subject_class: c.subject_class,
                    session: c.session_time,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }
}
