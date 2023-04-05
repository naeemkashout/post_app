import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/utils/extended_string.dart';
import 'package:post_app/features/posts/presntation/blocs/comment/comment_bloc.dart';
import 'package:post_app/features/posts/presntation/pages/add_update_comment_page.dart';

import '../../domain/entities/comment.dart';

class ViewCommentPage extends StatelessWidget {
   Comment comment;
  ViewCommentPage({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(comment.name,textAlign:TextAlign.center),
      ),
      body: BlocConsumer<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state is DoneDeleteCommentState) {
            ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('delete_comment'.tr(context))));
            BlocProvider.of<CommentBloc>(context)
                .add(GetCommentsFromPostIdEvent(postId: comment.id!));
            Navigator.of(context).pop();
          } else if (state is ErrorDeleteCommentState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('error_delete_comment : '.tr(context) +'${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is LoadingCommentState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Text(comment.name,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 24, 132, 186),
                    fontSize: 20,
                  ),
                  textAlign:TextAlign.center,
                  ),
                 const SizedBox(height: 10,),
              Text(comment.body,textAlign:TextAlign.center,),
             const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return AddUpdateCommentPage(
                                  isUpdate: true,
                                  comment: comment,
                                );
                              }));
                            },
                            icon: const Icon(Icons.edit, size: 15),
                            label:  Text(
                              'edit'.tr(context),
                              style: TextStyle(fontSize: 17),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton.icon(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: () {
                              BlocProvider.of<CommentBloc>(context)
                                  .add(DeleteCommentEvent(id: comment.id!));
                            },
                            icon: const Icon(Icons.delete, size: 16),
                            label:  Text('delete'.tr(context))),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
