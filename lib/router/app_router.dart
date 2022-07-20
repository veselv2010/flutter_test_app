import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:im_good_test_app/presentation/users/page.dart';
import 'package:im_good_test_app/presentation/users/user/albums/album_details/page.dart';
import 'package:im_good_test_app/presentation/users/user/albums/page.dart';
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
    path: Routes.user,
    page: UserPage,
    children: [
      AutoRoute(
        path: Routes.posts,
        page: UserPostsPage,
        children: [
          AutoRoute(
            path: Routes.comments,
            page: PostDetailsPage,
          )
        ],
      ),
      AutoRoute(
        path: Routes.albums,
        page: UserAlbumsPage,
        children: [
          AutoRoute(
            path: Routes.album,
            page: AlbumDetailsPage,
          ),
        ],
      ),
    ],
  ),
])
class AppRouter extends _$AppRouter {}
