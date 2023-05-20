import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:nike_shop_project/common/http_client.dart';
import 'package:nike_shop_project/data/Models/auth.dart';
import 'package:nike_shop_project/data/data/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpclient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangedNotifier =
      ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _presistAuthToken(authInfo);
  }

  @override
  Future<void> signUp(String username, String password) async {
    
      final AuthInfo authInfo = await dataSource.signUp(username, password);
      _presistAuthToken(authInfo);
    
  }

  @override
  Future<void> refreshToken() async {
    if (authChangedNotifier.value != null) {
      final AuthInfo authInfo = await dataSource
          .refreshToken(authChangedNotifier.value!.refreshToken);
      debugPrint("refresh token is:${authInfo.refreshToken} ");
      _presistAuthToken(authInfo);
    }
  }

  Future<void> _presistAuthToken(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
    loadAuthInfo();
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        await sharedPreferences.getString("access_token") ?? "";
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? "";
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangedNotifier.value = AuthInfo(accessToken, refreshToken);
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangedNotifier.value = null;
  }
}
