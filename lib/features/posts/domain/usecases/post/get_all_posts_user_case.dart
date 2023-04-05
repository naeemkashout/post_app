import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/repositories/post_repository.dart';
import '../../../../../core/errors/failures.dart';
import '../../entities/post.dart';

class GetAllPostsUserCase{
  final PostRepository postRepository;
  GetAllPostsUserCase({required this.postRepository});
   Future<Either<Failure,List<Post>>> call()async{
    return await postRepository.getAllPosts();
  }
}