import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:im_good_test_app/presentation/users/user/bloc/user_page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_good_test_app/presentation/users/user/widgets/address_info_tile.dart';
import 'package:im_good_test_app/presentation/users/user/widgets/albums_preview_tile.dart';
import 'package:im_good_test_app/presentation/users/user/widgets/company_info_tile.dart';
import 'package:im_good_test_app/presentation/users/user/widgets/posts_preview_tile.dart';
import 'package:im_good_test_app/presentation/users/user/widgets/user_info_tile.dart';
import 'package:im_good_test_app/presentation/widgets/auto_scaffold.dart';

class UserPage extends StatelessWidget {
  final String userId;

  const UserPage({Key? key, @pathParam required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) =>
            UserPageBloc()..add(UserPageInitialLoadEvent(id: userId)),
        child: BlocBuilder<UserPageBloc, UserPageState>(
          builder: (context, state) {
            if (state is UserPageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            state as UserPageLoaded;

            return AutoScaffold(
              title: state.user.username,
              body: ListView(children: [
                UserInfoTile(title: 'Name', description: state.user.name),
                UserInfoTile(title: 'Email', description: state.user.email),
                UserInfoTile(title: 'Phone', description: state.user.phone),
                UserInfoTile(title: 'Website', description: state.user.website),
                CompanyInfoTile(company: state.user.company),
                AddressInfoTile(address: state.user.address),
                PostsPreviewTile(posts: state.lastPosts),
                AlbumsPreviewTile(albums: state.lastAlbums),
              ]),
            );
          },
        ),
      ),
    );
  }
}
