import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/account/data/models/change_password_model.dart';

abstract class AccountRepository {
  Future<Either<Failures, String>> updateProfile(String fullname);

  Future<Either<Failures, String>> changePassword(
    ChangePasswordModel passwordData,
  );
}
