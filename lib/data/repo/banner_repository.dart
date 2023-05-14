import 'package:nike_shop_project/common/http_client.dart';
import 'package:nike_shop_project/data/data/banner_data_source.dart';
import 'package:nike_shop_project/data/Models/banner.dart';
import 'package:nike_shop_project/data/repo/product_repository.dart';

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpclient));

abstract class IBannerRepositoey {
  Future<List<BannerEntity>> getAll();
}

class BannerRepository implements IBannerRepositoey {
  final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);

  @override
  Future<List<BannerEntity>> getAll() => dataSource.getAll();
}
