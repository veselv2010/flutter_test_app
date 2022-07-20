import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(comment.name),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              comment.email,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(comment.body),
          ],
        ),
      ),
    );
  }
}
