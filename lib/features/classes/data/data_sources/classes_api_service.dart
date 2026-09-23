import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/classes/domain/entities/attendance/attendance_entity.dart';
import 'package:silab/features/classes/domain/entities/class_list_response/classes_response_entity.dart';
import 'package:silab/features/classes/domain/entities/classmates_response/classmates_response_entity.dart';
import 'package:silab/features/classes/domain/entities/meetings_response/meetings_response_entity.dart';

class ClassesApiService {
  final ApiClient _apiClient;

  const ClassesApiService(this._apiClient);

  Future<ClassesResponseEntity> getUserRegisteredClasses() async =>
      ClassesResponseEntity.fromJson(await _apiClient.get('/class/me'));

  Future<MeetingsResponseEntity> getUserMeetingsData({
    String? classId,
  }) async =>
      MeetingsResponseEntity.fromJson(
        await _apiClient.get('/meeting/$classId'),
      );

  Future<ClassmatesResponseEntity> getClassmates({String? classId}) async =>
      ClassmatesResponseEntity.fromJson(
        await _apiClient.get('/class/$classId/classmates'),
      );

  Future<AttendanceEntity> addUserAttendance({
    String? classId,
    String? meetingId,
    String? meetingToken,
  }) async =>
      AttendanceEntity.fromJson(
        await _apiClient.post(
          '/subject/classes/$classId/meetings/$meetingId/attendances',
          body: {'token': meetingToken},
        ),
      );
}
