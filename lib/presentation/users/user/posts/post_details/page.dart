import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/posts/post_details/bloc/post_details_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/posts/post_details/widgets/add_comment_button.dart';
import 'package:im_good_test_app/presentation/users/user/posts/post_details/widgets/comment_tile.dart';
import 'package:im_good_test_app/presentation/users/user/posts/post_details/widgets/post_widget.dart';
import 'package:im_good_test_app/presentation/widgets/auto_scaffold.dart';

class PostDetailsPage extends StatelessWidget {
  final String postId;
  const PostDetailsPage({
    Key? key,
    @pathParam required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) =>
            PostDetailsBloc()..add(PostDetailsInitialLoadEvent(postId: postId)),
        child: BlocBuilder<PostDetailsBloc, PostDetailsState>(
          builder: (context, state) {
            if (state is PostDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            state as PostDetailsLoaded;
            final commentWidgets = state.comments
                .map<Widget>((e) => CommentTile(comment: e))
                .toList();
            commentWidgets.add(AddCommentButton(postId: postId));
            return AutoScaffold(
              title: 'Post $postId',
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostWigdet(post: state.post),
                    const SizedBox(height: 8.0),
                    Text(
                      'Comments (${state.comments.length})',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: commentWidgets.length,
                        itemBuilder: (context, index) {
                          return commentWidgets.elementAt(index);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
