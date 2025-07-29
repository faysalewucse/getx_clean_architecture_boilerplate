import 'package:getx_clean_architecture_boilerplate/src/domain/repositories/auth_repository.dart';

class IsUserLoggedInUseCase {
  final AuthRepository repository;
  IsUserLoggedInUseCase(this.repository);

  bool execute() {
    return repository.isUserLoggedIn();
  }
}
