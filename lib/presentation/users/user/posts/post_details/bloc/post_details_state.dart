part of 'post_details_bloc.dart';

@immutable
abstract class PostDetailsState {}

class PostDetailsLoading extends PostDetailsState {}

class PostDetailsLoaded extends PostDetailsState {
  final Post post;
  final List<Comment> comments;
  PostDetailsLoaded({
    required this.post,
    required this.comments,
  });
}
