part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  
  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}
class LoadingCommentState extends CommentState{}

class LoadedCommentState extends CommentState{
  final List<Comment>comments;
 const LoadedCommentState({required this.comments});
  @override
  List<Object> get props => [comments];
}
class ErrorCommentState extends CommentState{
  String message;
  ErrorCommentState({required this.message});
   @override
  List<Object> get props => [message];
}
class ErrorGetCommentState extends CommentState {
 String message;
   ErrorGetCommentState({
    required this.message,
  });
   @override
  List<Object> get props => [message];
}

class DoneUpdateCommentState extends CommentState{}
class ErrorUpdateCommentState extends CommentState {
 String message;
  ErrorUpdateCommentState({
    required this.message,
  });
   @override
  List<Object> get props => [message];
}

class DoneAddCommentState extends CommentState{}
class ErrorAddCommentState extends CommentState {
 String message;
  ErrorAddCommentState({
    required this.message,
  });
   @override
  List<Object> get props => [message];
}
class DoneDeleteCommentState extends CommentState{}
class ErrorDeleteCommentState extends CommentState {
 String message;
  ErrorDeleteCommentState({
    required this.message,
  });
   @override
  List<Object> get props => [message];
}

