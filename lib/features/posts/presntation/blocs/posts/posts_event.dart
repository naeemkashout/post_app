// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostsEvent {}

class RefreshPostsEvent extends PostsEvent {}

class AddPostEvent extends PostsEvent {
  final Post post;
  const AddPostEvent({
    required this.post,
  });
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends PostsEvent {
  final Post post;
  const UpdatePostEvent({
    required this.post,
  });
  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends PostsEvent {
  final int postId;
  const DeletePostEvent({
    required this.postId,
  });
  @override
  List<Object> get props => [postId];
}
