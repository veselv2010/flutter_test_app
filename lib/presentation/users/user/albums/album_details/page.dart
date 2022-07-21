import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/albums/album_details/bloc/album_details_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/albums/album_details/bloc/image_component_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/albums/album_details/widgets/slider/slider_image.dart';
import 'package:im_good_test_app/presentation/widgets/auto_scaffold.dart';

class AlbumDetailsPage extends StatelessWidget {
  final String albumId;
  const AlbumDetailsPage({
    Key? key,
    @pathParam required this.albumId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AlbumDetailsBloc()..add(AlbumDetailsInitialLoadEvent(albumId)),
          ),
          BlocProvider(
            create: (context) => ImageComponentBloc(),
          ),
        ],
        child: BlocBuilder<AlbumDetailsBloc, AlbumDetailsState>(
          builder: (context, state) {
            if (state is AlbumDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            state as AlbumDetailsLoaded;
            return AutoScaffold(
              title: 'Album //${state.album.title}',
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: PageView.builder(
                          controller:
                              context.read<ImageComponentBloc>().pageController,
                          itemBuilder: (context, index) {
                            final photo = state.photos.elementAt(index);
                            return SliderImage(photo: photo);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          mainAxisExtent: 150,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: state.photos.length,
                        itemBuilder: (context, index) {
                          final photo = state.photos.elementAt(index);
                          return InkWell(
                            onTap: () {
                              context.read<ImageComponentBloc>().add(
                                  ImageComponentToSpecificPageEvent(index));
                            },
                            child: Image.network(photo.thumbnailUrl),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
