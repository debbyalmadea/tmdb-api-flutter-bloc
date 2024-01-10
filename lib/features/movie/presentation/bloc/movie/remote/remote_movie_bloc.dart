import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/core/resources/data_state.dart';
import 'package:flutter_tmdb/features/movie/domain/repository/movie_repository.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/get_movie.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_event.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_state.dart';

class RemoteMoviesBloc extends Bloc<RemoteMoviesEvent, RemoteMoviesState> {
  final GetMoviesUseCase _getMoviesUseCase;

  RemoteMoviesBloc(this._getMoviesUseCase) : super(RemoteMoviesLoading()) {
    on<GetMovies>(onGetMovies);
  }

  void onGetMovies(GetMovies event, Emitter<RemoteMoviesState> emit) async {
    final dataState = await _getMoviesUseCase(
        params: GetMoviesParams(
            page: event.page, sortByOption: event.sortByOption));

    // debugPrint('dataState: $dataState');
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteMoviesLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      // debugPrint('dataState.exception: ${dataState.exception}');
      emit(RemoteMoviesException(dataState.exception!));
    }
  }
}
