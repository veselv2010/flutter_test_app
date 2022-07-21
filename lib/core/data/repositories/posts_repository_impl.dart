import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:im_good_test_app/core/data/repositories/dio_response_handler_mixin.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/repositories/cache_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl
    with DioResponseHandlerMixin
    implements PostsRepository {
  final Dio httpClient;
  final CacheRepository cacheRepository;
  final _commentsKey = 'comments';
  final _postsKey = 'posts';

  PostsRepositoryImpl({
    required this.cacheRepository,
    required this.httpClient,
  });
  @override
  Future<List<Comment>> getCommentsForPost({required int postId}) async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _commentsKey,
      mapper: Comment.fromJson,
    );

    if (cache.isNotEmpty) {
      final cachedComments =
          cache.where((comment) => comment.postId == postId).toList();
      if (cachedComments.isNotEmpty) {
        return cachedComments;
      }
    }

    final res = await httpClient.get('/posts/$postId/comments');

    final comments = handleGenericListReponse<Comment>(
        res: res, mapper: (e) => Comment.fromJson(e));
    cache
      ..addAll(comments)
      ..sort((a, b) => a.id.compareTo(b.id));

    await cacheRepository.putValuesToCache(key: _commentsKey, values: cache);

    return comments;
  }

  @override
  Future<Post?> getPost({required int postId}) async {
    final cache = await cacheRepository.getValueFromCache(
      id: postId,
      key: _postsKey,
      mapper: Post.fromJson,
    );

    if (cache != null) {
      return cache;
    }

    final res = await httpClient.get('/posts/$postId');

    final post = handleGenericReponse<Post>(res: res, mapper: Post.fromJson);

    if (post == null) {
      return null;
    }

    await cacheRepository.putValueToCache(_postsKey, post);

    return post;
  }

  @override
  Future<List<Post>> getPostsForUser({required int userId}) async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _postsKey,
      mapper: Post.fromJson,
    );

    if (cache.isNotEmpty) {
      final cachedPosts = cache.where((post) => post.userId == userId).toList();
      if (cachedPosts.isNotEmpty) {
        return cachedPosts;
      }
    }

    final res = await httpClient.get('/users/$userId/posts');

    final posts = handleGenericListReponse<Post>(
        res: res, mapper: (e) => Post.fromJson(e));
    cache
      ..addAll(posts)
      ..sort((a, b) => a.id.compareTo(b.id));

    await cacheRepository.putValuesToCache(key: _postsKey, values: cache);

    return posts;
  }

  @override
  Future<bool> sendComment(
      {required String email,
      required String name,
      required String body,
      required int postId}) async {
    final post = await httpClient.post('/posts/$postId/comments', data: {
      'postId': postId,
      'name': name,
      'email': email,
      'body': body,
    });

    if (post.statusCode != 201) {
      return false;
    }

    final comment = Comment.fromJson(jsonEncode(post.data));

    await cacheRepository.putValueToCache(_commentsKey, comment);

    return true;
  }
}
