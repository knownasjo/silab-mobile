import 'package:either_dart/either.dart';
import 'package:silab/core/exceptions/exceptions.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/password_reset/data/data_sources/password_reset_api_service.dart';
import 'package:silab/features/password_reset/data/models/reset_password_model.dart';
import 'package:silab/features/password_reset/domain/entities/password_reset_entity.dart';
import 'package:silab/features/password_reset/domain/repository/password_reset_repository.dart';

class PasswordResetRepositoryImpl implements PasswordResetRepository {
  final PasswordResetApiService _passwordResetApiService;

  const PasswordResetRepositoryImpl(this._passwordResetApiService);

  @override
  Future<Either<Failures, PasswordResetEntity>> requestCode(String email) =>
      _guard(() => _passwordResetApiService.requestCode(email));

  @override
  Future<Either<Failures, String>> resetPassword(
    ResetPasswordModel resetData,
  ) =>
      _guard(() => _passwordResetApiService.resetPassword(resetData));

  Future<Either<Failures, T>> _guard<T>(Future<T> Function() request) async {
    try {
      return Right(await request());
    } on RequestErrorException catch (e) {
      final data = e.data;
      final email = data is Map ? data['email'] : null;

      if (email is String) {
        return Left(UnverifiedAccountFailures(e.message, email));
      }

      return Left(RequestFailures(e.message));
    }
  }
}
