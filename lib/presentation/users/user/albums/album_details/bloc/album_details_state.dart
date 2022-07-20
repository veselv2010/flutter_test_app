part of 'album_details_bloc.dart';

@immutable
abstract class AlbumDetailsState {}

class AlbumDetailsLoading extends AlbumDetailsState {}

class AlbumDetailsLoaded extends AlbumDetailsState {
  final Album album;
  final List<Photo> photos;

  AlbumDetailsLoaded(this.album, this.photos);
}
