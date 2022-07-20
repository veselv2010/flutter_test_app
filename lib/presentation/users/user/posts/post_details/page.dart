import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostDetailsPage extends StatelessWidget {
  final String postId;
  const PostDetailsPage({
    Key? key,
    @pathParam required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
