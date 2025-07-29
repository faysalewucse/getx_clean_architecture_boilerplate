import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:getx_clean_architecture_boilerplate/src/core/constants/api_urls.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/datasources/auth_remote_data_sources.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/models/login_request_model.dart';
import 'package:getx_clean_architecture_boilerplate/src/data/models/login_response_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginResponseModel?> login(LoginRequestModel request) async {
    try {
      final response = await client.post(ApiUrls.login, data: request.toJson());
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      debugPrint("🔴 myError: AuthRemoteDataSourceImpl : login() : $e");
    }
    return null;
  }

  @override
  Future<void> logout() async {
    try {
      await client.post(ApiUrls.logout);
    } catch (e) {
      debugPrint("🔴 myError: AuthRemoteDataSourceImpl : logout() : $e");
    }
  }
}
