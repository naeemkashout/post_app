part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostState extends PostsState {}

//Get
class LoadedPostsState extends PostsState {
  final List<Post> posts;
  const LoadedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String message;
  const ErrorPostsState({
    required this.message,
  });
  @override
  //compare the last state with the emited state
  List<Object> get props => [message];
}

//ADD
class DoneAddPostState extends PostsState {}

class ErrorAddPostState extends PostsState {
  final String message;
  const ErrorAddPostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

//Update
class DoneUpdatePostState extends PostsState {}

class ErrorUpdatePostState extends PostsState {
  final String message;
  const ErrorUpdatePostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

//Delete
class DoneDeletePostState extends PostsState {}

class ErrorDeletePostState extends PostsState {
  final String message;
  const ErrorDeletePostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
