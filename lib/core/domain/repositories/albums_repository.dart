import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';

abstract class AlbumsRepository {
  Future<Album?> getAlbum({required int albumId});
  Future<List<Album>> getAlbumsForUser({required int userId});
  Future<List<Photo>> getPhotos({required int albumId});
}
