import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPostsForUser({required int userId});
  Future<Post?> getPost({required int postId});

  Future<List<Comment>> getCommentsForPost({required int postId});
  Future<bool> sendComment({
    required String email,
    required String name,
    required String body,
    required int postId,
  });
}
