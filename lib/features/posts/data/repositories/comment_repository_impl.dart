import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/entities/comment.dart';
import 'package:post_app/core/errors/failures.dart';
import 'package:post_app/features/posts/domain/repositories/comment_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../datasources/comment_remoat_datasource.dart';
import '../models/comment_model.dart';

class CommentRepositoryImpl implements CommentRepository {
  CommentRemoatDataSource commentRemoatDataSource;
  CommentRepositoryImpl({required this.commentRemoatDataSource});

  @override
  Future<Either<Failure, Unit>> addComment(Comment comment) async {
    CommentModel commentModel = CommentModel(
        body: comment.body,
        email: comment.email,
        name: comment.name,
        postId: comment.postId);
    try {
      await commentRemoatDataSource.addComment(commentModel);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteComment(int id) async {
    try {
      await commentRemoatDataSource.deleteComment(id);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getCommentsFromPostId(
      int postId) async {
    try {
      return Right(await commentRemoatDataSource.getCommentsFromPostId(postId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateComment(Comment comment) async {
    CommentModel commentModel = CommentModel(
        body: comment.body,
        email: comment.email,
        name: comment.name,
        postId: comment.postId);
    try {
      await commentRemoatDataSource.updateComment(commentModel);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
