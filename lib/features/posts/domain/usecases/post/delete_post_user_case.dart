import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/repositories/post_repository.dart';

import '../../../../../core/errors/failures.dart';



class DeletePostUsercase{
  final PostRepository postRepository;
  DeletePostUsercase({required this.postRepository});
  Future<Either<Failure,Unit>> call(int id)async{
    return await postRepository.deletePost(id);
  }
}