import 'package:dartz/dartz.dart';
import 'package:post_app/core/errors/failures.dart';
import 'package:post_app/features/posts/domain/repositories/comment_repository.dart';

class DeleteCommentUserCase {
  CommentRepository commentRepository;
  DeleteCommentUserCase({required this.commentRepository});
  Future<Either<Failure, Unit>> call(int id) async {
    return await commentRepository.deleteComment(id);
  }
}
