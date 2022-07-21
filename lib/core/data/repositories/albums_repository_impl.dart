import 'package:dio/dio.dart';
import 'package:im_good_test_app/core/data/repositories/dio_response_handler_mixin.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/repositories/albums_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/cache_repository.dart';

class AlbumsRepositoryImpl
    with DioResponseHandlerMixin
    implements AlbumsRepository {
  final Dio httpClient;
  final CacheRepository cacheRepository;
  final String _albumsKey = 'albums';
  final String _photosKey = 'photos';

  AlbumsRepositoryImpl(
      {required this.cacheRepository, required this.httpClient});

  @override
  Future<List<Album>> getAlbumsForUser({required int userId}) async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _albumsKey,
      mapper: Album.fromJson,
    );

    if (cache.isNotEmpty) {
      final userAlbums =
          cache.where((album) => album.userId == userId).toList();
      if (userAlbums.isNotEmpty) {
        return userAlbums;
      }
    }

    final res = await httpClient.get('/users/$userId/albums');

    final albums = handleGenericListReponse<Album>(
        res: res, mapper: (e) => Album.fromJson(e));
    cache
      ..addAll(albums)
      ..sort((a, b) => a.id.compareTo(b.id));
    await cacheRepository.putValuesToCache(key: _albumsKey, values: cache);

    return albums;
  }

  @override
  Future<List<Photo>> getPhotos({required int albumId}) async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _photosKey,
      mapper: Photo.fromJson,
    );

    if (cache.isNotEmpty) {
      final albumPhotos =
          cache.where((photo) => photo.albumId == albumId).toList();
      if (albumPhotos.isNotEmpty) {
        return albumPhotos;
      }
    }

    final res = await httpClient.get('/albums/$albumId/photos');

    final photos = handleGenericListReponse<Photo>(
        res: res, mapper: (e) => Photo.fromJson(e));

    cache
      ..addAll(photos)
      ..sort((a, b) => a.id.compareTo(b.id));

    await cacheRepository.putValuesToCache(key: _photosKey, values: cache);

    return photos;
  }

  @override
  Future<Album?> getAlbum({required int albumId}) async {
    final cache = await cacheRepository.getValueFromCache(
      id: albumId,
      key: _albumsKey,
      mapper: Album.fromJson,
    );

    if (cache != null) {
      return cache;
    }

    final res = await httpClient.get('/albums/$albumId');

    final album =
        handleGenericReponse<Album>(res: res, mapper: (e) => Album.fromJson(e));

    if (album == null) {
      return null;
    }

    await cacheRepository.putValueToCache(_albumsKey, album);

    return album;
  }
}
