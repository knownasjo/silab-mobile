import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/registration/data/models/register_model.dart';
import 'package:silab/features/registration/domain/entities/registration_entity.dart';
import 'package:silab/features/registration/domain/repository/registration_repository.dart';

class RegisterUsecase {
  final RegistrationRepository registrationRepository;

  const RegisterUsecase(this.registrationRepository);

  Future<Either<Failures, RegistrationEntity>> call(
          RegisterModel registerData) =>
      registrationRepository.register(registerData);
}
