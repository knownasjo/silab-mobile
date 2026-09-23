import 'package:silab/features/classes/domain/repository/class_repository.dart';

class WatchClassEventsUsecase {
  final ClassRepository classRepository;

  const WatchClassEventsUsecase(this.classRepository);

  Stream<String> call({String? params}) =>
      classRepository.watchClassEvents(classId: params);
}
