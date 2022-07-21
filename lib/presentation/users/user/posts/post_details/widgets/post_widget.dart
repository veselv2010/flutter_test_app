import 'package:flutter/material.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';

class PostWigdet extends StatelessWidget {
  final Post post;
  const PostWigdet({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          post.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          post.body,
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }
}
