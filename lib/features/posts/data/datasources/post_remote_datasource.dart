import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:post_app/core/constants/server_config.dart';
import 'package:post_app/core/errors/exceptions.dart';
import 'package:post_app/features/posts/data/models/post_model.dart';

class PostRemoteDataSource {
  Future<Unit> addPost(PostModel post) async {
    final http.Response response = await http
        .post(Uri.parse(ServerConfig.addPost), body: jsonEncode(post.toJson()));
    if (response.statusCode == 201) {
      // Map<String, dynamic> map = jsonDecode(response.body);
      // if (map['result'] == 'ok') {
      return unit;
      // } else {
      //   throw ServerException();
      // }
    } else {
      throw ServerException();
    }
  }

  Future<Unit> deletePost(int id) async {
    final http.Response response =
        await http.delete(Uri.parse(ServerConfig.deletePost + '/$id'));
    if (response.statusCode == 200) {
      return unit;
      // Map<String, dynamic> map = jsonDecode(response.body);
      // if (map['result' == 'ok']) {
      //   return unit;
      // } else {
      //   throw ServerException();
      // }
    } else {
      throw ServerException();
    }
  }

  Future<Unit> updatePost(PostModel postModel) async {
    final http.Response response = await http.patch(
        Uri.parse(ServerConfig.updatePost + "/${postModel.id}"),
        body: jsonEncode(postModel.toJson()));
    if (response.statusCode == 200) {
      //architecture
      return unit;
    } else {
      throw ServerException();
    }
  }

  Future<List<PostModel>> getAllPosts() async {
    final http.Response response =
        await http.get(Uri.parse(ServerConfig.getAllPosts));
    if (response.statusCode == 200) {
      //List = List<Map<String,dynamic>>
      List list = jsonDecode(response.body);
      //list.map:convert from list type to onther list type
      return list.map((e) => PostModel.fromJson(e)).toList();
    } else {
      //like retutn but for exceptions
      throw ServerException();
    }
  }
}
