import 'package:getx_clean_architecture_boilerplate/src/domain/entities/user_entity.dart';

class LoginResponseModel {
  final String id;
  final String name;
  final String token;

  LoginResponseModel({
    required this.id,
    required this.name,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'],
      name: json['name'],
      token: json['token'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, token: token);
  }
}
