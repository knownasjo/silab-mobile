import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/subjects/domain/entities/subject_list_response/subject_list_response_entity.dart';
import 'package:silab/features/subjects/domain/entities/subject_response/subject_response_entity.dart';

class SubjectApiService {
  final ApiClient _apiClient;

  const SubjectApiService(this._apiClient);

  Future<SubjectListResponseEntity> getSubjectList() async =>
      SubjectListResponseEntity.fromJson(await _apiClient.get('/subject'));

  Future<SubjectResponseEntity> getSubjectDetails(String? subjectId) async =>
      SubjectResponseEntity.fromJson(
        await _apiClient.get('/subject/$subjectId'),
      );
}
