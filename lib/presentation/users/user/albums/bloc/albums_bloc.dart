import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/repositories/albums_repository.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';
import 'package:meta/meta.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final AlbumsRepository repository = GetIt.I.get();
  AlbumsBloc() : super(AlbumsLoading()) {
    on<AlbumsInitialLoadEvent>((event, emit) async {
      final albums =
          await repository.getAlbumsForUser(userId: int.parse(event.userId));

      emit(AlbumsLoaded(albums));
    });
  }
}
