import 'dart:convert';

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

    if (cache != null && cache.isNotEmpty) {
      return cache;
    }

    final res = await httpClient.get('/users/$userId/albums');
    final albums = handleGenericListReponse<Album>(
        res: res, mapper: (e) => Album.fromJson(e));

    await cacheRepository.putValuesToCache(key: _albumsKey, values: albums);

    return albums;
  }

  @override
  Future<List<Photo>> getPhotos({required int albumId}) async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _photosKey,
      mapper: Photo.fromJson,
    );

    if (cache != null && cache.isNotEmpty) {
      return cache;
    }

    final res = await httpClient.get('/albums/$albumId/photos');
    final photos = handleGenericListReponse<Photo>(
        res: res, mapper: (e) => Photo.fromJson(e));

    await cacheRepository.putValuesToCache(key: _albumsKey, values: photos);

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
