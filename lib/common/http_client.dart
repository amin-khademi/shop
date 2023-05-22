import 'package:dio/dio.dart';
import 'package:nike_shop_project/data/repo/auth_repository.dart';

final httpclient =
    Dio(BaseOptions(baseUrl: "http://expertdevelopers.ir/api/v1/"))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          final authInfo = AuthRepository.authChangedNotifier.value;
          if (authInfo != null && authInfo.accessToken.isNotEmpty) {
            options.headers["Authorization"] = "Bearer ${authInfo.accessToken}";
          }
          handler.next(options);
        },
      ));
