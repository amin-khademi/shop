import 'package:dio/dio.dart';
import 'package:nike_shop_project/common/constans.dart';
import 'package:nike_shop_project/common/validator.dart';
import 'package:nike_shop_project/data/Models/auth.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> signUp(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  final Dio httpclient;

  AuthRemoteDataSource(this.httpclient);
  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpclient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constans.clientSecret,
      "username": username,
      "password": password
    });
    validator(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> refreshToken(String token) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<AuthInfo> signUp(String username, String password) async {
    final response = await httpclient
        .post("user/register", data: {"email": username, "password": password});
    validator(response);
    return login(username, password);
  }
}
