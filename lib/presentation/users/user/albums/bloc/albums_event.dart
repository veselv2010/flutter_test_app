part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent {}

class AlbumsInitialLoadEvent extends AlbumsEvent {
  final String userId;

  AlbumsInitialLoadEvent(this.userId);
}
