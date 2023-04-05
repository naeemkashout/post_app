part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetCommentsFromPostIdEvent extends CommentEvent {
  final int postId;
 const GetCommentsFromPostIdEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
class RefreashCommentEvent extends CommentEvent {}

class AddCommentEvent extends CommentEvent{
  final Comment comment;
  const AddCommentEvent({required this.comment});
   @override
  List<Object> get props => [comment];
}

class DeleteCommentEvent extends CommentEvent{
  final int id;
 const DeleteCommentEvent({required this.id});
   @override
  List<Object> get props => [id];
}

class UpdateCommentEvent extends CommentEvent{
  final Comment comment;
 const UpdateCommentEvent({required this.comment});
   @override
  List<Object> get props => [comment];
}
