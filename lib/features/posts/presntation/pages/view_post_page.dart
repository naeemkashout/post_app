import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/features/posts/domain/entities/comment.dart';
import 'package:post_app/features/posts/presntation/blocs/comment/comment_bloc.dart';
import 'package:post_app/features/posts/presntation/blocs/posts/posts_bloc.dart';
import 'package:post_app/features/posts/presntation/pages/view_comment_page.dart';

import '../../domain/entities/post.dart';
import 'add_update_post_page.dart';
import 'package:post_app/core/utils/extended_string.dart';

class ViewPostPage extends StatelessWidget {
  Post post;
  Comment? comment;
  TextEditingController addCommentTitle = TextEditingController();
  TextEditingController addCommentBody = TextEditingController();
  ViewPostPage({this.comment, required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CommentBloc>(context)
        .add(GetCommentsFromPostIdEvent(postId: post.id!));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            post.title,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<PostsBloc, PostsState>(
              listener: (context, state) {
                if (state is DoneDeletePostState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('delete_post'.tr(context))));
                  BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
                  Navigator.of(context).pop();
                } else if (state is ErrorDeletePostState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('error_delete_post : '.tr(context) +
                          '${state.message}')));
                }
              },
              builder: (context, state) {
                if (state is LoadingPostState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  color: Colors.blueGrey[50],
                  child: Column(
                    children: [
                      Text(
                        post.title,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        post.body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return AddUpdatePostPage(
                                    isUpdate: true,
                                    post: post,
                                  );
                                }));
                              },
                              icon: const Icon(Icons.edit, size: 15),
                              label: Text(
                                'edit'.tr(context),
                                style: const TextStyle(fontSize: 17),
                              )),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton.icon(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                BlocProvider.of<PostsBloc>(context)
                                    .add(DeletePostEvent(postId: post.id!));
                              },
                              icon: const Icon(Icons.delete, size: 16),
                              label: Text('delete'.tr(context))),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              child: Text('comments'.tr(context),
                  style:
                      TextStyle(fontSize: 25, color: Colors.lightBlueAccent)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlueAccent, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.fromLTRB(30, 6, 30, 6),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<CommentBloc, CommentState>(
                  builder: ((context, state) {
                if (state is LoadingCommentState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedCommentState) {
                  List<Comment> comments = state.comments;
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<CommentBloc>(context)
                          .add(GetCommentsFromPostIdEvent(postId: post.id!));
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ViewCommentPage(
                                    comment: comments[index]);
                              },
                            ));
                          },
                          child: Column(children: [
                            Text(
                              textAlign: TextAlign.center,
                              comments[index].name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 24, 132, 186)),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              textAlign: TextAlign.center,
                              comments[index].body,
                            ),
                          ]),
                        );
                      },
                      separatorBuilder: ((context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      }),
                    ),
                  );
                } else if (state is ErrorCommentState) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Container();
              })),
            ),
          ],
        ),
      ),
    );
  }
}
