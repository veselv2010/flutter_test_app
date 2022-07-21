import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AutoScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  const AutoScaffold({
    Key? key,
    required this.body,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
        automaticallyImplyLeading: false,
        leading: const AutoLeadingButton(),
      ),
      body: body,
    );
  }
}
