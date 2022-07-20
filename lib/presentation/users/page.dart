import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';
import 'package:im_good_test_app/presentation/users/widgets/user_card.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);
  final UsersRepository repository = GetIt.I.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: repository.getUsers(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snap.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final user = data.elementAt(index);
              return UserCard(user: user);
            },
          );
        },
      ),
    );
  }
}
