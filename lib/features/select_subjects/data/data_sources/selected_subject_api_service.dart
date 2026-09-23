import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/select_subjects/domain/entities/add_selected_class_response/add_selected_class_response_entity.dart';
import 'package:silab/features/select_subjects/domain/entities/add_selected_subject_response/add_selected_subject_response_entity.dart';
import 'package:silab/features/select_subjects/domain/entities/selected_subject_response/selected_subject_response_entity.dart';
import 'package:silab/features/select_subjects/domain/entities/user_class_option_by_paid_subject_response/user_class_option_by_paid_subject_response_entity.dart';

class SelectedSubjectApiService {
  final ApiClient _apiClient;

  const SelectedSubjectApiService(this._apiClient);

  Future<SelectedSubjectResponseEntity> getUserSelectedSubject() async =>
      SelectedSubjectResponseEntity.fromJson(
        await _apiClient.get('/activation'),
      );

  Future<AddSelectedSubjectResponseEntity> addUserSelectedSubject(
    List<String>? subjects,
  ) async =>
      AddSelectedSubjectResponseEntity.fromJson(
        await _apiClient.post('/activation', body: {'subjectIds': subjects}),
      );

  Future<UserClassOptionByPaidSubjectResponseEntity>
      getUserClassOptionbyPaidSubjects() async =>
          UserClassOptionByPaidSubjectResponseEntity.fromJson(
            await _apiClient.get('/class/registration'),
          );

  Future<AddSelectedClassResponseEntity> addSelectedClass({
    List<String>? selectedClass,
  }) async =>
      AddSelectedClassResponseEntity.fromJson(
        await _apiClient.post(
          '/class/registration',
          body: {'classIds': selectedClass},
        ),
      );
}
