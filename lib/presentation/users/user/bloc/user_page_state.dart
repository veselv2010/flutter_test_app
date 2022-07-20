part of 'user_page_bloc.dart';

@immutable
abstract class UserPageState {}

class UserPageLoading extends UserPageState {}

class UserPageLoaded extends UserPageState {
  final User user;
  final List<Post> lastPosts;
  final List<Tuple2<Album, Photo?>> lastAlbums;

  UserPageLoaded({
    required this.user,
    required this.lastPosts,
    required this.lastAlbums,
  });
}
