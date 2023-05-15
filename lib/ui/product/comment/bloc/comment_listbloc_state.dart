part of 'comment_listbloc_bloc.dart';

abstract class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

class CommentListLoading extends CommentListState {}

class CommentListSuccess extends CommentListState {
  final List<CommentEntity> comments;

  const CommentListSuccess(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentListError extends CommentListState {
  final AppException exception;

  CommentListError(this.exception);

  @override
  // TODO: implement props
  List<Object> get props => [exception];
}
