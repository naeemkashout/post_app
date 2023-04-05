import 'package:dartz/dartz.dart';
import 'package:post_app/core/errors/failures.dart';

import '../entities/comment.dart';

abstract class CommentRepository{
  Future <Either<Failure,List<Comment>>>getCommentsFromPostId(int postId);
  Future <Either<Failure,Unit>>addComment(Comment comment);
  Future <Either<Failure,Unit>>updateComment(Comment comment);
  Future <Either<Failure,Unit>>deleteComment(int id);
  
}