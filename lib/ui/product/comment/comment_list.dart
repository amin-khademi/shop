import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop_project/data/repo/comment_repository.dart';
import 'package:nike_shop_project/ui/home/bloc/home_bloc.dart';
import 'package:nike_shop_project/ui/product/comment.dart';
import 'package:nike_shop_project/ui/product/comment/bloc/comment_listbloc_bloc.dart';
import 'package:nike_shop_project/ui/widgets/error.dart';

class CommentList extends StatelessWidget {
  final int productId;
  const CommentList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
            repository: commentRepository, productId: productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
          builder: (context, state) {
        if (state is CommentListSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return CommentItem(
                data: state.comments[index],
              );
            }, childCount: state.comments.length),
          );
        } else if (state is CommentListLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CommentListError) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
                exception: state.exception,
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                }),
          );
        } else {
          throw Exception("state is not supoorted");
        }
      }),
    );
  }
}
