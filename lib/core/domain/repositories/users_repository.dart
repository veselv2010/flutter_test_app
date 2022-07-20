import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers();
  Future<List<Comment>> getComments({required int postId});
  Future<List<Album>> getAlbums({required int userId});
  Future<List<Photo>> getPhotos({required int albumId});
  Future<List<Post>> getPosts({required int userId});

  Future<User?> getSpecificUser({required int id});
  Future<Comment?> getSpecificComment({required int id});
  Future<Album?> getSpecificAlbum({required int albumId});
  Future<Post?> getSpecificPost({required int userId, required int id});
}
