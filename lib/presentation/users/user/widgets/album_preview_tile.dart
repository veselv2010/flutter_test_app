import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/router/app_router.dart';
import 'package:tuple/tuple.dart';

class AlbumPreviewTile extends StatelessWidget {
  final Tuple2<Album, Photo?> data;
  const AlbumPreviewTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).navigate(
          AlbumDetailsPageRoute(
            albumId: data.item1.id.toString(),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: data.item2 == null
            ? const Text('No photos')
            : Image.network(data.item2!.thumbnailUrl),
      ),
    );
  }
}
