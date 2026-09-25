import 'package:either_dart/either.dart';
import 'package:silab/core/exceptions/exceptions.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/account/data/data_sources/account_api_service.dart';
import 'package:silab/features/account/data/models/change_password_model.dart';
import 'package:silab/features/account/domain/repository/account_repository.dart';
import 'package:silab/features/authentication/data/data_sources/local/authentication_local_datasource.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountApiService _accountApiService;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  const AccountRepositoryImpl(
    this._accountApiService,
    this._authenticationLocalDataSource,
  );

  @override
  Future<Either<Failures, String>> updateProfile(String fullname) =>
      _guard(() => _accountApiService.updateProfile(fullname));

  @override
  Future<Either<Failures, String>> changePassword(
    ChangePasswordModel passwordData,
  ) =>
      _guard(() async {
        final result = await _accountApiService.changePassword(passwordData);
        final accessToken = result.data?.accessToken;
        final refreshToken = result.data?.refreshToken;

        if (accessToken == null || refreshToken == null) {
          throw RequestErrorException('Respons server tidak lengkap.');
        }

        await _authenticationLocalDataSource.setUserTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        return result.message ?? 'Password berhasil diganti';
      });

  Future<Either<Failures, T>> _guard<T>(Future<T> Function() request) async {
    try {
      return Right(await request());
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }
}
