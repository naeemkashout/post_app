import 'package:get_it/get_it.dart';
import 'package:post_app/core/internet_connection/connectivity_internet_connection.dart';
import 'package:post_app/features/posts/data/datasources/comment_remoat_datasource.dart';
import 'package:post_app/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:post_app/features/posts/domain/usecases/commnet/add_comment_usercase.dart';
import 'package:post_app/features/posts/domain/usecases/commnet/delete_comment_usercase.dart';
import 'package:post_app/features/posts/domain/usecases/commnet/get_comments_usercase.dart';
import 'package:post_app/features/posts/domain/usecases/commnet/update_comment_usercase.dart';
import 'package:post_app/features/posts/presntation/blocs/comment/comment_bloc.dart';
import 'package:post_app/features/posts/presntation/blocs/posts/posts_bloc.dart';
import 'package:post_app/features/settings/presentation/cubits/localization/localization_cubit.dart';
import 'features/posts/data/repositories/comment_repository_impl.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/domain/usecases/post/add_post_user_case.dart';
import 'features/posts/domain/usecases/post/delete_post_user_case.dart';
import 'features/posts/domain/usecases/post/get_all_posts_user_case.dart';
import 'features/posts/domain/usecases/post/update_post_user_case.dart';
//sl will register all needed objects in it
final sl = GetIt.instance;
Future<void> init() async {
  //*features
  //*? post
  //!blocs
  sl.registerFactory(() => PostsBloc(
    //sl() will understand the only return type
      getAllPosts: sl(), addPost: sl(), updatePost: sl(), deletePost: sl()));
  //!usecases
  sl.registerLazySingleton(() => AddPostUserCase(postRepository: sl<PostRepositoryImpl>()));
  sl.registerLazySingleton(() => DeletePostUsercase(postRepository: sl<PostRepositoryImpl>()));
  sl.registerLazySingleton(() => GetAllPostsUserCase(postRepository: sl<PostRepositoryImpl>()));
  sl.registerLazySingleton(() => UpdatePostUserCase(postRepository: sl<PostRepositoryImpl>()));
  //!repositories
  sl.registerLazySingleton(() => PostRepositoryImpl(postRemoteDataSource:sl(),internetConnection: sl<ConnectivityInternetConnection>()));
  //!datasources
 sl.registerLazySingleton(() => PostRemoteDataSource());

 //*? comment
  //!blocs
  sl.registerFactory(() => CommentBloc(
    //co() will understand the only return type
      getCommentsFromPostIdUserCase: sl(),addCommentUserCase: sl(),deleteCommentUserCase:sl() ,updateCommentUseCase:sl() ));
  //!usecases
  sl.registerLazySingleton(() => AddCommentUserCase(commentRepository: sl<CommentRepositoryImpl>()));
  sl.registerLazySingleton(() => DeleteCommentUserCase(commentRepository: sl<CommentRepositoryImpl>()));
  sl.registerLazySingleton(() => GetCommentsFromPostIdUserCase(commentRepository: sl<CommentRepositoryImpl>()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(commentRepository: sl<CommentRepositoryImpl>()));
  //!repositories
  sl.registerLazySingleton(() => CommentRepositoryImpl(commentRemoatDataSource:sl()));
  //!datasources
  sl.registerLazySingleton(() => CommentRemoatDataSource());
   //*? settings
   //!cubits
   sl.registerLazySingleton(() => LocalizationCubit(),);
  //*core
  //*?internet connection
  sl.registerLazySingleton(() => ConnectivityInternetConnection());
  //*external
}
