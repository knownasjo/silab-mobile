import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/account/domain/repository/account_repository.dart';

class UpdateProfileUsecase {
  final AccountRepository accountRepository;

  const UpdateProfileUsecase(this.accountRepository);

  Future<Either<Failures, String>> call(String fullname) =>
      accountRepository.updateProfile(fullname);
}
