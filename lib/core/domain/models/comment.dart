import 'dart:convert';

import 'package:im_good_test_app/core/domain/models/i_serializable.dart';

class Comment implements ISerializible {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});

  Comment copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) {
    return Comment(
      postId: postId ?? this.postId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      postId: map['postId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(postId: $postId, id: $id, name: $name, email: $email, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.postId == postId &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.body == body;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        body.hashCode;
  }
}
