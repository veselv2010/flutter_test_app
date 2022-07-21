import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/data/repositories/cache_repository_impl.dart';
import 'package:im_good_test_app/core/data/repositories/users_repository_impl.dart';
import 'package:im_good_test_app/core/domain/repositories/cache_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';
import 'package:im_good_test_app/router/app_router.dart';

import 'core/data/repositories/albums_repository_impl.dart';
import 'core/data/repositories/posts_repository_impl.dart';
import 'core/domain/repositories/albums_repository.dart';
import 'core/domain/repositories/posts_repository.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final routerDelegate = AppRouter();

  @override
  void initState() {
    final httpClient =
        Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
    GetIt.I.registerSingleton<CacheRepository>(CacheRepositoryImpl());
    GetIt.I.registerSingleton<UsersRepository>(UsersRepositoryImpl(
        cacheRepository: GetIt.I.get(), httpClient: httpClient));
    GetIt.I.registerSingleton<AlbumsRepository>(AlbumsRepositoryImpl(
        cacheRepository: GetIt.I.get(), httpClient: httpClient));
    GetIt.I.registerSingleton<PostsRepository>(PostsRepositoryImpl(
        cacheRepository: GetIt.I.get(), httpClient: httpClient));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: routerDelegate.defaultRouteParser(),
      routerDelegate: routerDelegate.delegate(),
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
