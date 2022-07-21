import 'package:dio/dio.dart';
import 'package:im_good_test_app/core/data/repositories/dio_response_handler_mixin.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';
import 'package:im_good_test_app/core/domain/repositories/cache_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';

class UsersRepositoryImpl
    with DioResponseHandlerMixin
    implements UsersRepository {
  final Dio httpClient;
  final CacheRepository cacheRepository;
  final _usersKey = 'users';

  UsersRepositoryImpl(
      {required this.cacheRepository, required this.httpClient});

  @override
  Future<List<User>> getUsers() async {
    final cache = await cacheRepository.getValuesFromCache(
      key: _usersKey,
      mapper: User.fromJson,
    );

    if (cache.isNotEmpty) {
      return cache;
    }

    final res = await httpClient.get('/users/');
    final users =
        handleGenericListReponse<User>(res: res, mapper: User.fromJson);

    await cacheRepository.putValuesToCache(key: _usersKey, values: users);

    return users;
  }

  @override
  Future<User?> getSpecificUser({required int id}) async {
    final cache = await cacheRepository.getValueFromCache(
      id: id,
      key: _usersKey,
      mapper: User.fromJson,
    );

    if (cache != null) {
      return cache;
    }

    final res = await httpClient.get('/users/$id');
    final user = handleGenericReponse<User>(res: res, mapper: User.fromJson);
    if (user == null) {
      return null;
    }

    await cacheRepository.putValueToCache(_usersKey, user);

    return user;
  }
}
