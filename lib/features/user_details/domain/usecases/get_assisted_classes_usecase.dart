import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/user_details/domain/entities/assisted_class/assisted_class_entity.dart';
import 'package:silab/features/user_details/domain/repositories/user_repository.dart';

class GetAssistedClassesUsecase {
  final UserRepository userRepository;

  const GetAssistedClassesUsecase(this.userRepository);

  Future<Either<Failures, List<AssistedClassEntity>>> call() =>
      userRepository.getAssistedClasses();
}
