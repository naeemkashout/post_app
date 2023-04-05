import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:post_app/core/constants/server_config.dart';
import 'package:post_app/core/errors/exceptions.dart';
import 'package:post_app/features/posts/data/models/comment_model.dart';

class CommentRemoatDataSource {
  Future<Unit> addComment(CommentModel commentModel) async {
    final Response response = await http.post(
        Uri.parse(ServerConfig.addComment),
        body: jsonEncode(commentModel.toJson()));
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  Future<Unit> updateComment(CommentModel commentModel) async {
    final Response response = await http.patch(
        Uri.parse(ServerConfig.updateComment + '/${commentModel.id}'),
        body: jsonEncode(commentModel.toJson()));
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
  Future<Unit> deleteComment(int id) async {
    final Response  response = await http.delete(
       Uri.parse(ServerConfig.deleteComment +'/${id}'));        
    if (response.statusCode == 200) {
      return unit;
    } else {
      //throw :like return but from error
      throw ServerException();
    }
  }
  Future<List<CommentModel>> getCommentsFromPostId(int postId) async {
    final Response response = await http.get(
        Uri.parse(ServerConfig.getCommentsFromPostId + '/${postId}/comments'));
    if (response.statusCode == 200) {
       List list = jsonDecode(response.body);
       return list.map((e) => CommentModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
