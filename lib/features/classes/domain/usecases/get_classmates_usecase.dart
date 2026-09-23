import 'package:either_dart/either.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/core/usecases/usecases.dart';
import 'package:silab/features/classes/domain/entities/classmates_response/classmates_response_entity.dart';
import 'package:silab/features/classes/domain/repository/class_repository.dart';

class GetClassmatesUsecase
    implements UseCase<Either<Failures, ClassmatesResponseEntity>, String?> {
  final ClassRepository classRepository;

  const GetClassmatesUsecase(this.classRepository);

  @override
  Future<Either<Failures, ClassmatesResponseEntity>> call(
      {String? params}) async {
    return await classRepository.getClassmates(classId: params);
  }
}
