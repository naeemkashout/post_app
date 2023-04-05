import 'package:flutter/foundation.dart';

import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel(
      {required super.title, required super.body, super.id, super.userId});

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      body: map['body'],
      title: map['title'],
      id: map['id'],
      userId: map['userId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'title': title,
      'id': id,
      'userId': userId,
    };
  }
}
