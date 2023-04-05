import 'dart:convert';

import 'package:post_app/features/posts/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel(
      {super.id,
      required super.body,
      required super.email,
      required super.name,
      required super.postId});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'postId': postId,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as int,
      postId: map['postId'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      body: map['body'] as String,
    );
  }
}
