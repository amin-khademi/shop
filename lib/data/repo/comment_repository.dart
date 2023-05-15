import 'package:nike_shop_project/common/http_client.dart';
import 'package:nike_shop_project/data/Models/comments.dart';
import 'package:nike_shop_project/data/data/banner_data_source.dart';
import 'package:nike_shop_project/data/data/comment_data_source.dart';

final commentRepository =
    CommentRepository(CommentRemoteDataSource(httpclient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository(this.dataSource);
  @override
  Future<List<CommentEntity>> getAll({required int productId}) =>
      dataSource.getAll(ProductId: productId);
}
