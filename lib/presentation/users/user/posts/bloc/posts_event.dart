part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class PostsInitialLoading extends PostsEvent {
  final String userId;

  PostsInitialLoading(this.userId);
}
