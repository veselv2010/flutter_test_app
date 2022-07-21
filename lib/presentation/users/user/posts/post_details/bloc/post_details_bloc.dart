import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/repositories/posts_repository.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final PostsRepository repository = GetIt.I.get();

  PostDetailsBloc() : super(PostDetailsLoading()) {
    on<PostDetailsInitialLoadEvent>((event, emit) async {
      emit(PostDetailsLoading());
      final postId = int.parse(event.postId);
      final post = await repository.getPost(postId: postId);
      if (post == null) {
        throw Exception('Post ${event.postId} not found');
      }

      final comments = await repository.getCommentsForPost(postId: postId);

      emit(PostDetailsLoaded(post: post, comments: comments));
    });
  }
}
