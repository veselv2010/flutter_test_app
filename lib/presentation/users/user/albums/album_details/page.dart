import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlbumDetailsPage extends StatelessWidget {
  final String albumId;
  const AlbumDetailsPage({
    Key? key,
    @pathParam required this.albumId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
