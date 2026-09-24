import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/password_reset/domain/entities/password_reset_entity.dart';
import 'package:silab/features/password_reset/domain/repository/password_reset_repository.dart';

class RequestPasswordResetCodeUsecase {
  final PasswordResetRepository passwordResetRepository;

  const RequestPasswordResetCodeUsecase(this.passwordResetRepository);

  Future<Either<Failures, PasswordResetEntity>> call(String email) =>
      passwordResetRepository.requestCode(email);
}
