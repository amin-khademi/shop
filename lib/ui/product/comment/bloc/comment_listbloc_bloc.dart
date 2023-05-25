import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_shop_project/common/exception.dart';
import 'package:nike_shop_project/data/Models/comments.dart';
import 'package:nike_shop_project/data/repo/comment_repository.dart';
part 'comment_listbloc_event.dart';
part 'comment_listbloc_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentRepository repository;
  final int productId;
  CommentListBloc({required this.repository, required this.productId})
      : super(CommentListLoading()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStarted) {
        emit(CommentListLoading());
        try {
          final commments = await repository.getAll(productId: productId);
          emit(CommentListSuccess(commments));
        } catch (e) {
          emit(CommentListError(AppException()));
        }
      }
    });
  }
}
