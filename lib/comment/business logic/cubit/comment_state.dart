part of 'comment_cubit.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  @override
  List<Object> get props => [];
}


class CommentLoadingState extends CommentState {
  @override
  List<Object> get props => [];
}
class CommentLoadedState extends CommentState {
  final List<CommentModel> comments;

  const CommentLoadedState(this.comments);
  @override
  List<Object> get props => [comments];
}
class CommentErrorState extends CommentState {
  final String errorMessages;

  const CommentErrorState(this.errorMessages);
  @override
  List<Object> get props => [errorMessages];
}
