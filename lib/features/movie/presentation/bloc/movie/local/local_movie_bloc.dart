import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/get_saved_movie.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/remove_movie.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/save_movie.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_event.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_state.dart';

class LocalMoviesBloc extends Bloc<LocalMoviesEvent, LocalMoviesState> {
  final GetSavedMovieUseCase _getSavedMovies;
  final SaveMovieUseCase _saveMovie;
  final RemoveMovieUseCase _removeMovie;

  LocalMoviesBloc(this._getSavedMovies, this._saveMovie, this._removeMovie)
      : super(const LocalMoviesLoading()) {
    on<GetSavedMovies>(onGetSavedMovies);
    on<RemoveMovie>(onRemoveMovie);
    on<SaveMovie>(onSaveMovie);
  }

  void onGetSavedMovies(
      GetSavedMovies event, Emitter<LocalMoviesState> emit) async {
    final movies = await _getSavedMovies();
    emit(LocalMoviesLoaded(movies));
  }

  void onRemoveMovie(RemoveMovie event, Emitter<LocalMoviesState> emit) async {
    await _removeMovie(params: event.movie);
    final movies = await _getSavedMovies();
    emit(LocalMoviesLoaded(movies));
  }

  void onSaveMovie(SaveMovie event, Emitter<LocalMoviesState> emit) async {
    await _saveMovie(params: event.movie);
    final movies = await _getSavedMovies();
    emit(LocalMoviesLoaded(movies));
  }
}
