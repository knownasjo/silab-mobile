import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/password_reset/data/models/reset_password_model.dart';
import 'package:silab/features/password_reset/domain/repository/password_reset_repository.dart';

class ResetPasswordUsecase {
  final PasswordResetRepository passwordResetRepository;

  const ResetPasswordUsecase(this.passwordResetRepository);

  Future<Either<Failures, String>> call(ResetPasswordModel resetData) =>
      passwordResetRepository.resetPassword(resetData);
}
