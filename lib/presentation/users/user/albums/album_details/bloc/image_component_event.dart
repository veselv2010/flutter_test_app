part of 'image_component_bloc.dart';

@immutable
abstract class ImageComponentEvent {}

class ImageComponentNextPageEvent extends ImageComponentEvent {}

class ImageComponentPrevPageEvent extends ImageComponentEvent {}

class ImageComponentToSpecificPageEvent extends ImageComponentEvent {
  final int newPage;

  ImageComponentToSpecificPageEvent(this.newPage);
}
