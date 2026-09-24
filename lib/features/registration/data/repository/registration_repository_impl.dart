import 'package:either_dart/either.dart';
import 'package:silab/core/exceptions/exceptions.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/authentication/data/data_sources/local/authentication_local_datasource.dart';
import 'package:silab/features/registration/data/data_sources/registration_api_service.dart';
import 'package:silab/features/registration/data/models/register_model.dart';
import 'package:silab/features/registration/domain/entities/registration_entity.dart';
import 'package:silab/features/registration/domain/repository/registration_repository.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationApiService _registrationApiService;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  const RegistrationRepositoryImpl(
    this._registrationApiService,
    this._authenticationLocalDataSource,
  );

  @override
  Future<Either<Failures, RegistrationEntity>> register(
    RegisterModel registerData,
  ) =>
      _guard(() => _registrationApiService.register(registerData));

  @override
  Future<Either<Failures, RegistrationEntity>> resendCode(String email) =>
      _guard(() => _registrationApiService.resendCode(email));

  @override
  Future<Either<Failures, String>> verify(String email, String code) =>
      _guard(() async {
        final result = await _registrationApiService.verify(email, code);
        final accessToken = result.data?.accessToken;
        final refreshToken = result.data?.refreshToken;

        if (accessToken == null || refreshToken == null) {
          throw RequestErrorException('Respons server tidak lengkap.');
        }

        await _authenticationLocalDataSource.setUserTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        return result.message ?? 'Akun berhasil dibuat';
      });

  Future<Either<Failures, T>> _guard<T>(Future<T> Function() request) async {
    try {
      return Right(await request());
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }
}
