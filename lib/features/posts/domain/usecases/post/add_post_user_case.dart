import 'package:dartz/dartz.dart';
import 'package:post_app/core/errors/failures.dart';
import 'package:post_app/features/posts/domain/entities/post.dart';
import 'package:post_app/features/posts/domain/repositories/post_repository.dart';

class AddPostUserCase {
  final PostRepository postRepository;
  AddPostUserCase({required this.postRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.addPost(post);
  }
}
