import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/widgets/post_preview_tile.dart';
import 'package:im_good_test_app/presentation/widgets/auto_scaffold.dart';

import 'bloc/posts_bloc.dart';

class UserPostsPage extends StatelessWidget {
  final String userId;
  const UserPostsPage({
    Key? key,
    @pathParam required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => PostsBloc()..add(PostsInitialLoading(userId)),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            state as PostsLoaded;
            return AutoScaffold(
              title: 'All posts',
              body: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts.elementAt(index);
                  return PostPreviewTile(post: post);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
