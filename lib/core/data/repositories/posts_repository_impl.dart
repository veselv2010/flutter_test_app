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
  Future<List<Comment>> getComments({required int postId}) async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _commentsKey,
      mapper: Comment.fromJson,
    );

    if (cache != null && cache.isNotEmpty) {
      return cache;
    }

    final res = await httpClient.get('/posts/$postId/comments');
    final comments = handleGenericListReponse<Comment>(
        res: res, mapper: (e) => Comment.fromJson(e));

    await cacheRepository.putValuesToCache(key: _commentsKey, values: comments);

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
  Future<List<Post>> getPosts() async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _postsKey,
      mapper: Post.fromJson,
    );

    if (cache != null && cache.isNotEmpty) {
      return cache;
    }

    final res = await httpClient.get('/posts');
    final posts =
        handleGenericListReponse<Post>(res: res, mapper: Post.fromJson);

    await cacheRepository.putValuesToCache(key: _postsKey, values: posts);

    return posts;
  }

  @override
  Future<List<Post>> getPostsForUser({required int userId}) async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _postsKey,
      mapper: Post.fromJson,
    );

    if (cache != null && cache.isNotEmpty) {
      return cache;
    }

    final res = await httpClient.get('/users/$userId/posts');
    final posts = handleGenericListReponse<Post>(
        res: res, mapper: (e) => Post.fromJson(e));

    await cacheRepository.putValuesToCache(key: _postsKey, values: posts);

    return posts;
  }

  @override
  Future<bool> sendComment(
      {required String email,
      required String name,
      required String text,
      required int postId}) {
    // TODO: implement sendComment
    throw UnimplementedError();
  }
}
