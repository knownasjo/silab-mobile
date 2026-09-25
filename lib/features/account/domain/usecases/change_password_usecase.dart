import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/account/data/models/change_password_model.dart';
import 'package:silab/features/account/domain/repository/account_repository.dart';

class ChangePasswordUsecase {
  final AccountRepository accountRepository;

  const ChangePasswordUsecase(this.accountRepository);

  Future<Either<Failures, String>> call(ChangePasswordModel passwordData) =>
      accountRepository.changePassword(passwordData);
}
