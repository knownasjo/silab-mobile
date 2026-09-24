import 'package:silab/features/authentication/domain/repositories/authentication_repository.dart';

class WatchSessionEndedUsecase {
  final AuthenticationRepository authenticationRepository;

  const WatchSessionEndedUsecase(this.authenticationRepository);

  Stream<void> call() => authenticationRepository.watchSessionEnded();
}
