import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

part 'user_page_event.dart';
part 'user_page_state.dart';

class UserPageBloc extends Bloc<UserPageEvent, UserPageState> {
  final UsersRepository repository = GetIt.I.get();
  UserPageBloc() : super(UserPageLoading()) {
    on<UserPageInitialLoadEvent>((event, emit) async {
      final userId = int.parse(event.id);
      final user = await repository.getSpecificUser(id: userId);

      if (user == null) throw Exception('User is null');

      final posts = await repository.getPosts(userId: userId);
      final albums = await repository.getAlbums(userId: userId);

      final previews = <Tuple2<Album, Photo?>>[];

      final futures = albums.take(3).map((album) async {
        final photos = await repository.getPhotos(albumId: album.id);
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
          lastPosts: posts.take(3).toList(),
          lastAlbums: previews,
        ),
      );
    });
  }
}