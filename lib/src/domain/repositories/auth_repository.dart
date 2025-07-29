import 'package:getx_clean_architecture_boilerplate/src/data/models/login_request_model.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({required LoginRequestModel loginReqModel});
}
