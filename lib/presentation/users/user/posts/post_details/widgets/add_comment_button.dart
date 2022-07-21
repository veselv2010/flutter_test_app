import 'package:flutter/material.dart';
import 'package:im_good_test_app/presentation/users/user/posts/post_details/widgets/add_comment_dialog.dart';

class AddCommentButton extends StatelessWidget {
  final String postId;
  const AddCommentButton({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddCommentDialog(postId: int.parse(postId)),
        );
      },
      child: const Text('Add comment'),
    );
  }
}
