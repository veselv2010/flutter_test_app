import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
  final String title;
  final String description;
  const UserInfoTile({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
