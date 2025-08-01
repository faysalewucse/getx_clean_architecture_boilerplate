import 'package:getx_clean_architecture_boilerplate/src/domain/repositories/auth_repository.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/datasources/auth_remote_data_sources.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/models/login_request_model.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/entities/user_entity.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/services/storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final StorageService storageService = StorageService();

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login({required LoginRequestModel loginReqModel}) async {
    final response = await remoteDataSource.login(loginReqModel);
    if (response == null) {
      throw Exception('Login failed');
    }
    return response.toEntity();
  }

  @override
  bool isUserLoggedIn() {
    final token = storageService.getAuthToken();
    return token != null && token.isNotEmpty;
  }
}
