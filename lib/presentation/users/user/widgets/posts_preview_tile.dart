import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/presentation/users/user/widgets/post_preview_tile.dart';
import 'package:im_good_test_app/router/app_router.dart';

class PostsPreviewTile extends StatelessWidget {
  final List<Post> posts;
  const PostsPreviewTile({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text('Last posts', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    AutoRouter.of(context).navigate(UserPostsPageRoute());
                  },
                  child: const Text('Show all'))
            ],
          ),
        ),
        ...posts.take(3).map((e) => PostPreviewTile(post: e)),
      ],
    );
  }
}
