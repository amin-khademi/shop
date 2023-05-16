import 'dart:ffi';

import 'package:nike_shop_project/common/http_client.dart';
import 'package:nike_shop_project/data/Models/auth.dart';
import 'package:nike_shop_project/data/data/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpclient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
  }

  @override
  Future<void> signUp(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, password);
    } catch (e) {
      e.toString();
    }
  }
}
