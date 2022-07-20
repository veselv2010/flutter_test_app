part of 'album_details_bloc.dart';

@immutable
abstract class AlbumDetailsEvent {}

class AlbumDetailsInitialLoadEvent extends AlbumDetailsEvent {
  final String albumId;

  AlbumDetailsInitialLoadEvent(this.albumId);
}
