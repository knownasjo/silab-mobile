import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/core/usecases/usecases.dart';
import 'package:silab/features/authentication/domain/repositories/authentication_repository.dart';

class UserLogoutUsecase implements UseCase<Either<Failures, String>, Null> {
  final AuthenticationRepository authenticationRepository;

  const UserLogoutUsecase(this.authenticationRepository);

  @override
  Future<Either<Failures, String>> call({Null params}) async {
    return authenticationRepository.logout();
  }
}
