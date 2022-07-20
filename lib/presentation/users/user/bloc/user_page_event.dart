part of 'user_page_bloc.dart';

@immutable
abstract class UserPageEvent {}

class UserPageInitialLoadEvent extends UserPageEvent {
  final String id;
  UserPageInitialLoadEvent({
    required this.id,
  });
}
