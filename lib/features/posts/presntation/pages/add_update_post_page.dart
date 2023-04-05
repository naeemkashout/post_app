import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/utils/extended_string.dart';
import 'package:post_app/features/posts/presntation/blocs/posts/posts_bloc.dart';
import 'package:post_app/features/posts/presntation/pages/posts_page.dart';

import '../../domain/entities/post.dart';

class AddUpdatePostPage extends StatelessWidget {
  Post? post;
  bool isUpdate;
  AddUpdatePostPage({this.post, required this.isUpdate, super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = post!.title;
      bodyController.text = post!.body;
    }
    return Scaffold(
      appBar: AppBar(
              centerTitle: true,
                title:Text(isUpdate?post!.title:'add_post'.tr(context),),
                ),
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: (_, state) {
          if (state is DoneAddPostState || state is DoneUpdatePostState) {
            String messageName =
                state is DoneAddPostState ? 'added'.tr(context) : 'updated'.tr(context);
                //*?ScaffoldMessenger: ingected automatical from materialApp
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Post'.tr(context)+ messageName +'successfully'.tr(context)),
              backgroundColor: Colors.green,
            ));
            
            if (isUpdate) {
              Navigator.of(context).pop();
            } else {
              BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
              //*?Navigator: ingected automatical from materialApp
              Navigator.of(context).pop();
            }
          } else if (state is ErrorAddPostState ||
              state is ErrorUpdatePostState) {
            String message = '';
            String messageName = '';
            if (state is ErrorAddPostState) {
              message = state.message;
              messageName = 'adding'.tr(context);
            } else if (state is ErrorUpdatePostState) {
              message = state.message;
              messageName = 'updating';
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text('error_when'.tr(context) +messageName +'post : '.tr(context)+message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingPostState) {
            return const Center(child: CircularProgressIndicator());
          }
          return  Container(
            margin:const EdgeInsets.all(10),
            child: Column(            
              children: [
                TextField(
                  
                   obscureText: false,
           decoration: InputDecoration(
             labelText:'post_title'.tr(context),
           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
                  style:const TextStyle(color: Colors.blue),
                  controller: titleController,
                ),
                const SizedBox(height: 10,),     
                TextField(controller: bodyController,
                minLines: 1,
                decoration: InputDecoration(
                  labelText:'post_body'.tr(context),
                  
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                maxLines: 6,
                ),
                const SizedBox(height: 20,),       
                
                   ElevatedButton(
                      onPressed: (){
                        BlocProvider.of<PostsBloc>(context).add(isUpdate
                            ? UpdatePostEvent(           
                                post: Post(                         
                                title: titleController.text,
                                body: bodyController.text,
                                id: post!.id,
                              ))
                            : AddPostEvent(
                                post: Post(
                                   title: titleController.text,
                                    body: bodyController.text)));
                      },
                      child: Text(isUpdate ? 'update'.tr(context) : 'add'.tr(context))),
                  
              ],
            ),
          );
        },
      ),
    );
  }
}
