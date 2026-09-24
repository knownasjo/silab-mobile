import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/registration/domain/repository/registration_repository.dart';

class VerifyRegistrationUsecase {
  final RegistrationRepository registrationRepository;

  const VerifyRegistrationUsecase(this.registrationRepository);

  Future<Either<Failures, String>> call(String email, String code) =>
      registrationRepository.verify(email, code);
}
