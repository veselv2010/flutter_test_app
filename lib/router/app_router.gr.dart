// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    UsersPageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const UsersPage());
    },
    UserPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserPageRouteArgs>(
          orElse: () =>
              UserPageRouteArgs(userId: pathParams.getString('userId')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: UserPage(key: args.key, userId: args.userId));
    },
    UserPostsPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserPostsPageRouteArgs>(
          orElse: () => const UserPostsPageRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: UserPostsPage(
              key: args.key, userId: pathParams.getString('userId')));
    },
    UserAlbumsPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserAlbumsPageRouteArgs>(
          orElse: () => const UserAlbumsPageRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: UserAlbumsPage(
              key: args.key, userId: pathParams.getString('userId')));
    },
    PostDetailsPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PostDetailsPageRouteArgs>(
          orElse: () =>
              PostDetailsPageRouteArgs(postId: pathParams.getString('postId')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PostDetailsPage(key: args.key, postId: args.postId));
    },
    AlbumDetailsPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AlbumDetailsPageRouteArgs>(
          orElse: () => AlbumDetailsPageRouteArgs(
              albumId: pathParams.getString('albumId')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: AlbumDetailsPage(key: args.key, albumId: args.albumId));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(UsersPageRoute.name, path: '/'),
        RouteConfig(UserPageRoute.name, path: '/:userId', children: [
          RouteConfig(UserPostsPageRoute.name,
              path: 'posts',
              parent: UserPageRoute.name,
              children: [
                RouteConfig(PostDetailsPageRoute.name,
                    path: ':postId', parent: UserPostsPageRoute.name)
              ]),
          RouteConfig(UserAlbumsPageRoute.name,
              path: 'albums',
              parent: UserPageRoute.name,
              children: [
                RouteConfig(AlbumDetailsPageRoute.name,
                    path: ':albumId', parent: UserAlbumsPageRoute.name)
              ])
        ])
      ];
}

/// generated route for
/// [UsersPage]
class UsersPageRoute extends PageRouteInfo<void> {
  const UsersPageRoute() : super(UsersPageRoute.name, path: '/');

  static const String name = 'UsersPageRoute';
}

/// generated route for
/// [UserPage]
class UserPageRoute extends PageRouteInfo<UserPageRouteArgs> {
  UserPageRoute(
      {Key? key, required String userId, List<PageRouteInfo>? children})
      : super(UserPageRoute.name,
            path: '/:userId',
            args: UserPageRouteArgs(key: key, userId: userId),
            rawPathParams: {'userId': userId},
            initialChildren: children);

  static const String name = 'UserPageRoute';
}

class UserPageRouteArgs {
  const UserPageRouteArgs({this.key, required this.userId});

  final Key? key;

  final String userId;

  @override
  String toString() {
    return 'UserPageRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [UserPostsPage]
class UserPostsPageRoute extends PageRouteInfo<UserPostsPageRouteArgs> {
  UserPostsPageRoute({Key? key, List<PageRouteInfo>? children})
      : super(UserPostsPageRoute.name,
            path: 'posts',
            args: UserPostsPageRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'UserPostsPageRoute';
}

class UserPostsPageRouteArgs {
  const UserPostsPageRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'UserPostsPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [UserAlbumsPage]
class UserAlbumsPageRoute extends PageRouteInfo<UserAlbumsPageRouteArgs> {
  UserAlbumsPageRoute({Key? key, List<PageRouteInfo>? children})
      : super(UserAlbumsPageRoute.name,
            path: 'albums',
            args: UserAlbumsPageRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'UserAlbumsPageRoute';
}

class UserAlbumsPageRouteArgs {
  const UserAlbumsPageRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'UserAlbumsPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [PostDetailsPage]
class PostDetailsPageRoute extends PageRouteInfo<PostDetailsPageRouteArgs> {
  PostDetailsPageRoute({Key? key, required String postId})
      : super(PostDetailsPageRoute.name,
            path: ':postId',
            args: PostDetailsPageRouteArgs(key: key, postId: postId),
            rawPathParams: {'postId': postId});

  static const String name = 'PostDetailsPageRoute';
}

class PostDetailsPageRouteArgs {
  const PostDetailsPageRouteArgs({this.key, required this.postId});

  final Key? key;

  final String postId;

  @override
  String toString() {
    return 'PostDetailsPageRouteArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [AlbumDetailsPage]
class AlbumDetailsPageRoute extends PageRouteInfo<AlbumDetailsPageRouteArgs> {
  AlbumDetailsPageRoute({Key? key, required String albumId})
      : super(AlbumDetailsPageRoute.name,
            path: ':albumId',
            args: AlbumDetailsPageRouteArgs(key: key, albumId: albumId),
            rawPathParams: {'albumId': albumId});

  static const String name = 'AlbumDetailsPageRoute';
}

class AlbumDetailsPageRouteArgs {
  const AlbumDetailsPageRouteArgs({this.key, required this.albumId});

  final Key? key;

  final String albumId;

  @override
  String toString() {
    return 'AlbumDetailsPageRouteArgs{key: $key, albumId: $albumId}';
  }
}
