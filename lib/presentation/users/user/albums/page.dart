import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserAlbumsPage extends StatelessWidget {
  final String userId;
  const UserAlbumsPage({Key? key, @pathParam required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}