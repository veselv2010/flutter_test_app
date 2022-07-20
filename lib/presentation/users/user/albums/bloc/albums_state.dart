part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;

  AlbumsLoaded(this.albums);
}
