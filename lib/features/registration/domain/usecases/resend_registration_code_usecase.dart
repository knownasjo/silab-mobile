import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/registration/domain/entities/registration_entity.dart';
import 'package:silab/features/registration/domain/repository/registration_repository.dart';

class ResendRegistrationCodeUsecase {
  final RegistrationRepository registrationRepository;

  const ResendRegistrationCodeUsecase(this.registrationRepository);

  Future<Either<Failures, RegistrationEntity>> call(String email) =>
      registrationRepository.resendCode(email);
}
