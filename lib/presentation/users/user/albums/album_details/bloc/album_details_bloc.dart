import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/core/domain/repositories/albums_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';
import 'package:meta/meta.dart';

part 'album_details_event.dart';
part 'album_details_state.dart';

class AlbumDetailsBloc extends Bloc<AlbumDetailsEvent, AlbumDetailsState> {
  final AlbumsRepository repository = GetIt.I.get();

  AlbumDetailsBloc() : super(AlbumDetailsLoading()) {
    on<AlbumDetailsInitialLoadEvent>((event, emit) async {
      final albumId = int.parse(event.albumId);
      final album = await repository.getAlbum(albumId: albumId);
      if (album == null) {
        throw Exception('Album ${event.albumId} does not exist');
      }
      final photos = await repository.getPhotos(albumId: albumId);

      emit(AlbumDetailsLoaded(album, photos));
    });
  }
}
