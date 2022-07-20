import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/presentation/users/user/albums/album_details/bloc/image_component_bloc.dart';

class SliderImage extends StatelessWidget {
  final Photo photo;

  const SliderImage({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.network(photo.url)),
        const SizedBox(height: 4),
        Text(
          photo.title,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
