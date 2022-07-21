import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';
import 'package:im_good_test_app/core/domain/repositories/albums_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/posts_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';

import 'package:tuple/tuple.dart';

part 'user_page_event.dart';
part 'user_page_state.dart';

class UserPageBloc extends Bloc<UserPageEvent, UserPageState> {
  final PostsRepository postsRepository = GetIt.I.get();
  final UsersRepository usersRepository = GetIt.I.get();
  final AlbumsRepository albumsRepository = GetIt.I.get();
  UserPageBloc() : super(UserPageLoading()) {
    on<UserPageInitialLoadEvent>((event, emit) async {
      final userId = int.parse(event.id);
      final user = await usersRepository.getSpecificUser(id: userId);

      if (user == null) throw Exception('User is null');

      final posts = await postsRepository.getPostsForUser(userId: userId);
      final albums = await albumsRepository.getAlbumsForUser(userId: userId);

      final previews = <Tuple2<Album, Photo?>>[];

      final futures = albums.take(3).map((album) async {
        final photos = await albumsRepository.getPhotos(albumId: album.id);
        if (photos.isNotEmpty) {
          previews.add(Tuple2(album, photos.first));
        } else {
          previews.add(Tuple2(album, null));
        }
      });

      await Future.wait(futures);

      emit(
        UserPageLoaded(
          user: user,
          lastPosts: posts.toList(),
          lastAlbums: previews,
        ),
      );
    });
  }
}
