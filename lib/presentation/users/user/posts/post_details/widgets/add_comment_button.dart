import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/posts/post_details/bloc/post_details_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/posts/post_details/widgets/add_comment_dialog.dart';

class AddCommentButton extends StatefulWidget {
  final String postId;
  const AddCommentButton({Key? key, required this.postId}) : super(key: key);

  @override
  State<AddCommentButton> createState() => _AddCommentButtonState();
}

class _AddCommentButtonState extends State<AddCommentButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final res = await showDialog(
          context: context,
          builder: (context) =>
              AddCommentDialog(postId: int.parse(widget.postId)),
        );

        if (res == true && mounted) {
          context
              .read<PostDetailsBloc>()
              .add(PostDetailsInitialLoadEvent(postId: widget.postId));
        }
      },
      child: const Text('Add comment'),
    );
  }
}
