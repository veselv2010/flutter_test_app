import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/router/app_router.dart';

class PostPreviewTile extends StatelessWidget {
  final Post post;
  const PostPreviewTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(
        post.body,
        maxLines: 1,
      ),
      trailing: const RotatedBox(
        quarterTurns: 2,
        child: Icon(Icons.arrow_back_ios),
      ),
      onTap: () {
        AutoRouter.of(context).navigate(
          PostDetailsPageRoute(postId: post.id.toString()),
        );
      },
    );
  }
}
