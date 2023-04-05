import 'package:dartz/dartz.dart';
import 'package:post_app/core/errors/failures.dart';
import 'package:post_app/features/posts/domain/repositories/comment_repository.dart';

import '../../entities/comment.dart';

class UpdateCommentUseCase{
  CommentRepository commentRepository;
  UpdateCommentUseCase({required this.commentRepository});
  Future<Either<Failure,Unit>>call(Comment comment)async{
    return await commentRepository.updateComment(comment);
  }
}