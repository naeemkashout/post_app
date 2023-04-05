import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:post_app/core/errors/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/post/add_post_user_case.dart';
import '../../../domain/usecases/post/delete_post_user_case.dart';
import '../../../domain/usecases/post/get_all_posts_user_case.dart';
import '../../../domain/usecases/post/update_post_user_case.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUserCase getAllPosts;
  final AddPostUserCase addPost;
  final UpdatePostUserCase updatePost;
  final DeletePostUsercase deletePost;

  PostsBloc(
      {required this.getAllPosts,
      required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      emit(LoadingPostState());

      if (event is GetAllPostsEvent) {
        final eitherPosts = await getAllPosts();

        eitherPosts.fold((failure) {
          emit(ErrorPostsState(message: _getMessageFromFailure(failure)));
        }, (list) {
          emit(LoadedPostsState(posts: list));
        });
      } else if (event is AddPostEvent) {
        final eitherResult = await addPost(event.post);
        eitherResult.fold((failure) {
          emit(ErrorAddPostState(message: _getMessageFromFailure(failure)));
        }, (_) {
          emit(DoneAddPostState());
        });
      } else if (event is UpdatePostEvent) {
        final eitherResult = await updatePost(event.post);
        eitherResult.fold((failure) {
          emit(ErrorUpdatePostState(message: _getMessageFromFailure(failure)));
        }, (_) {
          emit(DoneUpdatePostState());
        });
      } else if (event is DeletePostEvent) {
        final eitherResoult = await deletePost(event.postId);
        eitherResoult.fold((failure) {
          emit(ErrorDeletePostState(message: _getMessageFromFailure(failure)));
        }, (_) {
          emit(DoneDeletePostState());
        });
      }
    });
  }
  String _getMessageFromFailure(Failure failure) {
    String message = '';
    if (failure is ServerFailure) {
      message = 'Server Error';
    } else if (failure is OfflineFailure) {
      message = 'Please Check Your Internet Connection';
    } else if (failure is EmptyFailure) {
      message = 'No Posts Found';
    }
    return message;
  }
}
