import 'package:dio/dio.dart';
import 'package:nike_shop_project/common/validator.dart';

import '../models/banner.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio httpclient;

  BannerRemoteDataSource(this.httpclient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpclient.get("banner/slider");
    validator(response);
    final List<BannerEntity> banners = [];
    (response.data as List).forEach((element) {
      banners.add(BannerEntity.fromjson(element));
    });
    return banners;
  }
}
