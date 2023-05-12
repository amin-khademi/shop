import 'package:dio/dio.dart';

import 'exception.dart';

mixin HttpResponseValidator {
  validator(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
