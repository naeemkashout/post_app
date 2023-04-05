import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/utils/extended_string.dart';
import 'package:post_app/features/posts/presntation/blocs/comment/comment_bloc.dart';
import 'package:post_app/features/posts/presntation/pages/view_post_page.dart';
import '../../domain/entities/comment.dart';

class AddUpdateCommentPage extends StatelessWidget {
  Comment? comment;
  bool isUpdate;
  AddUpdateCommentPage({required this.isUpdate, this.comment, super.key});
  TextEditingController bodyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      nameController.text = comment!.name;
      bodyController.text = comment!.body;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isUpdate ? comment!.name : 'add_comment'.tr(context),
          style: const TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: BlocConsumer<CommentBloc, CommentState>(
        listener: (_, state) {
          if (state is DoneAddCommentState || state is DoneUpdateCommentState) {
            String messageName = state is DoneAddCommentState
                ? 'added'.tr(context)
                : 'updated'.tr(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('comment'.tr(context) +
                  '$messageName' +
                  'successfully'.tr(context)),
              backgroundColor: Colors.green,
            ));

            if (isUpdate) {
              // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              //   return ViewPostPage(post: );
              // }
              // ));
            } else {
              BlocProvider.of<CommentBloc>(context)
                  .add(GetCommentsFromPostIdEvent(postId: comment!.id!));
              Navigator.of(context).pop();
            }
          } else if (state is ErrorAddCommentState ||
              state is ErrorUpdateCommentState) {
            String message = '';
            String messageName = '';
            if (state is ErrorAddCommentState) {
              message = state.message;
              messageName = 'adding'.tr(context);
            } else if (state is ErrorUpdateCommentState) {
              message = state.message;
              messageName = 'updating'.tr(context);
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text('error_when'.tr(context) +
                    messageName +
                    'comment : '.tr(context) +
                    message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingCommentState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(
                  color: Color.fromARGB(255, 24, 132, 186),
                ),
                controller: nameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'name'.tr(context),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: bodyController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'name'.tr(context),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CommentBloc>(context).add(isUpdate
                        ? UpdateCommentEvent(
                            comment: Comment(
                            postId: comment!.postId,
                            email: emailController.text,
                            name: nameController.text,
                            body: bodyController.text,
                            id: comment!.id,
                          ))
                        : AddCommentEvent(
                            comment: Comment(
                            postId: comment!.postId,
                            email: emailController.text,
                            name: nameController.text,
                            body: bodyController.text,
                            id: comment!.id,
                          )));
                  },
                  child: Text(
                      isUpdate ? 'update'.tr(context) : 'add'.tr(context))),
            ],
          );
        },
      ),
    );
  }
}
