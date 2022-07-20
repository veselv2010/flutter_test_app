import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final Dio httpClient;

  UsersRepositoryImpl(this.httpClient) {
    httpClient.options.baseUrl = 'https://jsonplaceholder.typicode.com';
  }

  @override
  Future<List<Album>> getAlbums({required int userId}) async {
    final res = await httpClient.get('/users/$userId/albums');
    if (res.statusCode == 200) {
      final serialized = jsonDecode(res.data) as List;
      return serialized.map((e) => Album.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<List<Comment>> getComments({required int postId}) async {
    final res = await httpClient.get('/posts/$postId/comments');
    if (res.statusCode == 200) {
      final serialized = jsonDecode(res.data) as List;
      return serialized.map((e) => Comment.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<List<Photo>> getPhotos({required int albumId}) async {
    final res = await httpClient.get('/albums/$albumId/photos');
    if (res.statusCode == 200) {
      final serialized = jsonDecode(res.data) as List;
      return serialized.map((e) => Photo.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<List<Post>> getPosts({required int userId}) async {
    final res = await httpClient.get('/users/$userId/posts');
    if (res.statusCode == 200) {
      final serialized = jsonDecode(res.data) as List;
      return serialized.map((e) => Post.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<List<User>> getUsers() async {
    final res = await httpClient.get('/users/');
    if (res.statusCode == 200) {
      final serialized = jsonDecode(res.data) as List;
      return serialized.map((e) => User.fromJson(e)).toList();
    }

    return [];
  }
}
