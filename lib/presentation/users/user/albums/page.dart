import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/albums/bloc/albums_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/albums/widgets/album_tile.dart';
import 'package:im_good_test_app/presentation/widgets/auto_scaffold.dart';

class UserAlbumsPage extends StatelessWidget {
  final String userId;
  const UserAlbumsPage({Key? key, @pathParam required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => AlbumsBloc()..add(AlbumsInitialLoadEvent(userId)),
        child: BlocBuilder<AlbumsBloc, AlbumsState>(
          builder: (context, state) {
            if (state is AlbumsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            state as AlbumsLoaded;
            return AutoScaffold(
              title: 'Albums',
              body: ListView.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums.elementAt(index);
                  return AlbumTile(album: album);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
