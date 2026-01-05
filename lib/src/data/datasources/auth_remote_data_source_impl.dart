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
    // Remove try-catch - let interceptor handle errors
    // final response = await client.post(ApiUrls.login, data: request.toJson());
    // return LoginResponseModel.fromJson(response.data);

    // Fake response for testing
    await Future.delayed(const Duration(seconds: 2));
    return LoginResponseModel(token: 'fake_token', name: "Faysal Ahmed", id: '123456');
  }

  @override
  Future<void> logout() async {
    await client.post(ApiUrls.logout);
  }
}
