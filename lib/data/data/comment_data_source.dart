import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop_project/common/validator.dart';
import 'package:nike_shop_project/data/Models/comments.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntity>> getAll({required int ProductId});
}

class CommentRemoteDataSource
    with HttpResponseValidator
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);
  @override
  Future<List<CommentEntity>> getAll({required int ProductId}) async {
    final response = await httpClient.get("comment/list?product_id=$ProductId");
    validator(response);
    final List<CommentEntity> commens = [];
    (response.data as List).forEach((element) {
      commens.add(CommentEntity.fromjson(element));
    });
    return commens;
  }
}
