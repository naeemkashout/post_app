import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Post extends Equatable {
  int? userId;
  int? id;
  String title;
  String body;
  Post({
    this.id,
    this.userId,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [userId, id, title, body];
}
