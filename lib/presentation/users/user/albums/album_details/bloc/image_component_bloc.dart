import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'image_component_event.dart';
part 'image_component_state.dart';

class ImageComponentBloc
    extends Bloc<ImageComponentEvent, ImageComponentState> {
  final PageController pageController = PageController();

  ImageComponentBloc() : super(ImageComponentState()) {
    on<ImageComponentNextPageEvent>((event, emit) {
      _toNextImage();
    });
    on<ImageComponentPrevPageEvent>((event, emit) {
      _toPreviousImage();
    });
    on<ImageComponentToSpecificPageEvent>((event, emit) {
      pageController.animateToPage(event.newPage,
          duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void _toPreviousImage() => pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );

  void _toNextImage() => pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
}
