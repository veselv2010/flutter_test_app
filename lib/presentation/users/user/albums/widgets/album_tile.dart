import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/router/app_router.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  const AlbumTile({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(album.title),
      onTap: () {
        AutoRouter.of(context).navigate(
          AlbumDetailsPageRoute(
            albumId: album.id.toString(),
          ),
        );
      },
    );
  }
}
