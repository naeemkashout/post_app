import 'package:dartz/dartz.dart';
import 'package:post_app/core/errors/failures.dart';
import 'package:post_app/features/posts/domain/repositories/comment_repository.dart';

import '../../entities/comment.dart';

class GetCommentsFromPostIdUserCase{
  CommentRepository commentRepository;
  GetCommentsFromPostIdUserCase({required this.commentRepository});
  Future<Either<Failure,List<Comment>>>call(int postId)async{
   Either<Failure,List<Comment>>either=  await commentRepository.getCommentsFromPostId(postId);
    return either;
  }
}