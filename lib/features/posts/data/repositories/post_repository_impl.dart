import 'package:http/http.dart';
import 'package:post_app/core/errors/exceptions.dart';
import 'package:post_app/core/internet_connection/internet_connection.dart';
import 'package:post_app/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:post_app/features/posts/data/models/post_model.dart';
import 'package:post_app/features/posts/domain/entities/post.dart';
import 'package:post_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final InternetConnection internetConnection;

  PostRepositoryImpl(
      {required this.internetConnection, required this.postRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    internetConnection.isOnline();
    PostModel postModel = PostModel(
        title: post.title, body: post.body, id: post.id, userId: post.userId);
    try {
      await postRemoteDataSource.addPost(postModel);

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    try {
      await postRemoteDataSource.deletePost(id);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    try {
      List<Post> s = await postRemoteDataSource.getAllPosts();
      return Right(s);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostModel postModel = PostModel(
        title: post.title, body: post.body, id: post.id, userId: post.userId);
    try {
      await postRemoteDataSource.updatePost(postModel);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
