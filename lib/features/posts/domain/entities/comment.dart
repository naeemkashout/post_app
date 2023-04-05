import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  int postId;
  int? id;
  String name;
  String email;
  String body;
  Comment(
      {this.id,
      required this.postId,
      required this.body,
      required this.email,
      required this.name});

  @override
  List<Object?> get props => throw UnimplementedError();
}
