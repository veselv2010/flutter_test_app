import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class UserHelperPage extends StatelessWidget {
  final String userId;

  const UserHelperPage({Key? key, @pathParam required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
