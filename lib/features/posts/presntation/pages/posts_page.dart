import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/utils/extended_string.dart';
import 'package:post_app/features/posts/domain/entities/post.dart';
import 'package:post_app/features/posts/presntation/blocs/posts/posts_bloc.dart';
import 'package:post_app/features/posts/presntation/pages/add_update_post_page.dart';
import 'package:post_app/features/posts/presntation/pages/view_post_page.dart';
import 'package:post_app/features/settings/presentation/pages/settings_page.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  bool _isVisable = true;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisable == true) {
          print("**** ${_isVisable} up");
          setState(() {
            _isVisable = false;
          });
        }
      } else {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisable == false) {
            print("**** ${_isVisable} down");
            setState(() {
              _isVisable = true;
            });
          }
        }
      }
    });
    BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('posts'.tr(context)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage();
                  },
                ));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: Visibility(
        visible: _isVisable,
        child: FloatingActionButton.extended(
          extendedPadding: const EdgeInsets.all(10),
          label: Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 5),
              Text(
                'add_post'.tr(context),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return AddUpdatePostPage(
                isUpdate: false,
              );
            }));
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: BlocBuilder<PostsBloc, PostsState>(builder: ((context, state) {
          if (state is LoadingPostState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedPostsState) {
            List<Post> posts = state.posts;
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
              },
              child: ListView.separated(
                controller: _scrollController,
                itemCount: posts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ViewPostPage(post: posts[index]);
                        },
                      ));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '${posts[index].id}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          margin: const EdgeInsets.fromLTRB(7, 5, 7, 7),
                        ),
                        Expanded(
                          child: Column(children: [
                            Text(
                              textAlign: TextAlign.center,
                              posts[index].title,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Center(child: Text(posts[index].body)),
                          ]),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
              ),
            );
          } else if (state is ErrorPostsState) {
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
    );
  }
}
