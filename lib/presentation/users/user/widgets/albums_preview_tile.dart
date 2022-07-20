import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/presentation/users/user/widgets/photo_preview_tile.dart';
import 'package:im_good_test_app/router/app_router.dart';
import 'package:tuple/tuple.dart';

class AlbumsPreviewTile extends StatelessWidget {
  final List<Tuple2<Album, Photo?>> albums;
  const AlbumsPreviewTile({Key? key, required this.albums}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('Last albums',
                  style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).navigate(UserAlbumsPageRoute());
                },
                child: const Text('Show all'),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: albums
                .map((e) => Expanded(child: AlbumPreviewTile(data: e)))
                .toList(),
          )
        ],
      ),
    );
  }
}
