import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/select_subjects/domain/repository/selected_subject_repository.dart';

class CancelActivationUsecase {
  final SelectedSubjectRepository selectedSubjectRepository;

  const CancelActivationUsecase(this.selectedSubjectRepository);

  Future<Either<Failures, String>> call(String activationId) =>
      selectedSubjectRepository.cancelActivation(activationId);
}
