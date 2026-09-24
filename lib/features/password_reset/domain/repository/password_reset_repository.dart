import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/password_reset/data/models/reset_password_model.dart';
import 'package:silab/features/password_reset/domain/entities/password_reset_entity.dart';

abstract class PasswordResetRepository {
  Future<Either<Failures, PasswordResetEntity>> requestCode(String email);

  Future<Either<Failures, String>> resetPassword(ResetPasswordModel resetData);
}
