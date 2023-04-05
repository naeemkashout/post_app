import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_app/features/posts/domain/usecases/commnet/get_comments_usercase.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/usecases/commnet/add_comment_usercase.dart';
import '../../../domain/usecases/commnet/delete_comment_usercase.dart';
import '../../../domain/usecases/commnet/update_comment_usercase.dart';
import '../posts/posts_bloc.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentUserCase addCommentUserCase;
  final DeleteCommentUserCase deleteCommentUserCase;
  final GetCommentsFromPostIdUserCase getCommentsFromPostIdUserCase;
  final UpdateCommentUseCase updateCommentUseCase;
  CommentBloc(
      {required this.addCommentUserCase,
      required this.deleteCommentUserCase,
      required this.getCommentsFromPostIdUserCase,
      required this.updateCommentUseCase})
      : super(CommentInitial()) {
    on<CommentEvent>((event, emit)async{
      emit(LoadingCommentState());
      if(event is GetCommentsFromPostIdEvent){
       (await getCommentsFromPostIdUserCase(event.postId)).fold((failure) {
         emit(ErrorGetCommentState(message: _getMessageFromFailure(failure)));
        }, (list){
         emit(LoadedCommentState(comments: list));
        });
      }else if(event is AddCommentEvent){
       final eitherComments=await addCommentUserCase(event.comment);
       eitherComments.fold((failure) {
         emit(ErrorAddCommentState(message: _getMessageFromFailure(failure)));
       }, (_) {
        emit(DoneAddCommentState());
       });
      }else if(event is UpdateCommentEvent){
       final eitherComments=await updateCommentUseCase(event.comment);
       eitherComments.fold((failure) {
         emit(ErrorUpdateCommentState(message: _getMessageFromFailure(failure)));
       }, (_) {
        emit(DoneUpdateCommentState());
       });
      }else if(event is DeleteCommentEvent){
       final eitherComments=await deleteCommentUserCase(event.id);
       eitherComments.fold((failure) {
         emit(ErrorDeleteCommentState(message: _getMessageFromFailure(failure)));
       }, (_) {
        emit(DoneDeleteCommentState());
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
