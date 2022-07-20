import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:im_good_test_app/presentation/users/page.dart';
import 'package:im_good_test_app/presentation/users/user/albums/album_details/page.dart';
import 'package:im_good_test_app/presentation/users/user/albums/page.dart';
import 'package:im_good_test_app/presentation/users/user/helper_page.dart';
import 'package:im_good_test_app/presentation/users/user/page.dart';
import 'package:im_good_test_app/presentation/users/user/posts/page.dart';
import 'package:im_good_test_app/presentation/users/user/posts/post_details/page.dart';
import 'package:im_good_test_app/router/routes.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(
    initial: true,
    path: Routes.users,
    page: UsersPage,
  ),
  AutoRoute(
    usesPathAsKey: true,
    path: Routes.user,
    page: UserHelperPage,
    children: [
      AutoRoute(
        initial: true,
        path: '',
        page: UserPage,
      ),
      AutoRoute(
        usesPathAsKey: true,
        path: Routes.posts,
        page: UserPostsPage,
      ),
      AutoRoute(
        usesPathAsKey: true,
        path: Routes.comments,
        page: PostDetailsPage,
      ),
      AutoRoute(
        usesPathAsKey: true,
        path: Routes.albums,
        page: UserAlbumsPage,
      ),
      AutoRoute(
        usesPathAsKey: true,
        path: Routes.album,
        page: AlbumDetailsPage,
      ),
    ],
  ),
])
class AppRouter extends _$AppRouter {}
