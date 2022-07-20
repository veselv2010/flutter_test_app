import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';
import 'package:im_good_test_app/router/app_router.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.username),
      subtitle: Text(user.name),
      onTap: () {
        AutoRouter.of(context)
            .navigate(UserHelperPageRoute(userId: user.id.toString()));
      },
    );
  }
}
