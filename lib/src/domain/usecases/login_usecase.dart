import 'package:getx_clean_architecture_boilerplate/src/data/models/login_request_model.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> execute({required LoginRequestModel loginReqModel}) {
    return repository.login(loginReqModel: loginReqModel);
  }
}
