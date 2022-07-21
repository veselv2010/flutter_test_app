import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/repositories/posts_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository = GetIt.I.get();

  PostsBloc() : super(PostsLoading()) {
    on<PostsInitialLoading>((event, emit) async {
      final posts =
          await repository.getPostsForUser(userId: int.parse(event.userId));
      emit(PostsLoaded(posts));
    });
  }
}
