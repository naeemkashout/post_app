import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/repositories/post_repository.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/post.dart';

class UpdatePostUserCase{
  final PostRepository postRepository;
  UpdatePostUserCase({required this.postRepository});
   Future<Either<Failure,Unit>> call(Post post)async{
    return await postRepository.updatePost(post);
  }
}