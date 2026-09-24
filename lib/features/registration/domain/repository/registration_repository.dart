import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/registration/data/models/register_model.dart';
import 'package:silab/features/registration/domain/entities/registration_entity.dart';

abstract class RegistrationRepository {
  Future<Either<Failures, RegistrationEntity>> register(
    RegisterModel registerData,
  );

  Future<Either<Failures, RegistrationEntity>> resendCode(String email);

  Future<Either<Failures, String>> verify(String email, String code);
}
