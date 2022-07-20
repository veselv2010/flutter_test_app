import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/repositories/cache_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final Dio httpClient;
  final CacheRepository cacheRepository;

  UsersRepositoryImpl({required this.cacheRepository, Dio? httpClient})
      : httpClient = httpClient ?? Dio() {
    this.httpClient.options.baseUrl = 'https://jsonplaceholder.typicode.com';
  }

  @override
  Future<List<Album>> getAlbums({required int userId}) async {
    final res = await httpClient.get('/users/$userId/albums');
    if (res.statusCode == 200) {
      final serialized = res.data as List;
      return serialized.map((e) => Album.fromJson(jsonEncode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Comment>> getComments({required int postId}) async {
    final res = await httpClient.get('/posts/$postId/comments');
    if (res.statusCode == 200) {
      final serialized = res.data as List;
      return serialized.map((e) => Comment.fromJson(jsonEncode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Photo>> getPhotos({required int albumId}) async {
    final res = await httpClient.get('/albums/$albumId/photos');
    if (res.statusCode == 200) {
      final serialized = res.data as List;
      return serialized.map((e) => Photo.fromJson(jsonEncode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<Post>> getPosts({required int userId}) async {
    final res = await httpClient.get('/users/$userId/posts');
    if (res.statusCode == 200) {
      final serialized = res.data as List;
      return serialized.map((e) => Post.fromJson(jsonEncode(e))).toList();
    }

    return [];
  }

  @override
  Future<List<User>> getUsers() async {
    final res = await httpClient.get('/users/');
    if (res.statusCode == 200) {
      final serialized = res.data as List;
      return serialized.map((e) => User.fromJson(jsonEncode(e))).toList();
    }

    return [];
  }

  @override
  Future<Album?> getSpecificAlbum({required int albumId}) async {
    final res = await httpClient.get('/albums/$albumId');
    if (res.statusCode == 200) {
      final serialized = res.data as Map;
      return Album.fromJson(jsonEncode(serialized));
    }

    return null;
  }

  @override
  Future<Post?> getSpecificPost({required int postId}) async {
    final res = await httpClient.get('/posts/$postId');
    if (res.statusCode == 200) {
      final serialized = res.data as Map;
      return Post.fromJson(jsonEncode(serialized));
    }

    return null;
  }

  @override
  Future<User?> getSpecificUser({required int id}) async {
    final res = await httpClient.get('/users/$id');
    if (res.statusCode == 200) {
      final serialized = res.data as Map;
      return User.fromJson(jsonEncode(serialized));
    }

    return null;
  }

  @override
  Future<Post?> sendComment(
      {required String email,
      required String name,
      required String text,
      required int postId}) async {
    final requiredCommentId = cacheRepository.getValuesFromCache<Comment>();
  }
}
