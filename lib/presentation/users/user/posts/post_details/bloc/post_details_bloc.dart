import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';
import 'package:meta/meta.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final UsersRepository repository = GetIt.I.get();

  PostDetailsBloc() : super(PostDetailsLoading()) {
    on<PostDetailsInitialLoadEvent>((event, emit) async {
      emit(PostDetailsLoading());
      final postId = int.parse(event.postId);
      final post = await repository.getSpecificPost(postId: postId);
      if (post == null) {
        throw Exception('Post ${event.postId} not found');
      }

      final comments = await repository.getComments(postId: postId);

      emit(PostDetailsLoaded(post: post, comments: comments));
    });
    on<PostDetailsSendCommentEvent>(
      (event, emit) async {},
    );
  }
}
