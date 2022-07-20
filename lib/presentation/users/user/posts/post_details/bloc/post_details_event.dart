part of 'post_details_bloc.dart';

@immutable
abstract class PostDetailsEvent {}

class PostDetailsSendCommentEvent extends PostDetailsEvent {
  final String name;
  final String email;
  final String text;

  PostDetailsSendCommentEvent({
    required this.name,
    required this.email,
    required this.text,
  });
}

class PostDetailsInitialLoadEvent extends PostDetailsEvent {
  final String postId;
  PostDetailsInitialLoadEvent({
    required this.postId,
  });
}
