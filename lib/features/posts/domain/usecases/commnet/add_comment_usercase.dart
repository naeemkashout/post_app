import 'package:dartz/dartz.dart';
import 'package:post_app/core/errors/failures.dart';
import 'package:post_app/features/posts/domain/entities/comment.dart';
import 'package:post_app/features/posts/domain/repositories/comment_repository.dart';

class AddCommentUserCase {
  CommentRepository commentRepository;
  AddCommentUserCase({required this.commentRepository});
  Future<Either<Failure,Unit>>call(Comment comment)async{
   return await commentRepository.addComment(comment);
  }
}