import 'package:im_good_test_app/core/domain/models/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers();

  Future<User?> getSpecificUser({required int id});
}
