import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/features/movie/domain/repository/movie_repository.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/get_saved_movie.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/get_saved_movies.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/remove_movie.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/save_movie.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_event.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_state.dart';

class LocalMoviesBloc extends Bloc<LocalMoviesEvent, LocalMoviesState> {
  final GetSavedMoviesUseCase _getSavedMovies;
  final SaveMovieUseCase _saveMovie;
  final RemoveMovieUseCase _removeMovie;
  final GetSavedMovieUseCase _getSavedMovie;

  LocalMoviesBloc(this._getSavedMovies, this._saveMovie, this._removeMovie,
      this._getSavedMovie)
      : super(const LocalMoviesLoading()) {
    on<GetSavedMovies>(onGetSavedMovies);
    on<RemoveMovie>(onRemoveMovie);
    on<SaveMovie>(onSaveMovie);
    on<GetSavedMovie>(onGetSavedMovie);
  }

  void onGetSavedMovies(
      GetSavedMovies event, Emitter<LocalMoviesState> emit) async {
    final movies = await _getSavedMovies();
    emit(LocalMoviesLoaded(movies));
  }

  void onGetSavedMovie(
      GetSavedMovie event, Emitter<LocalMoviesState> emit) async {
    final movie = await _getSavedMovie(params: GetSavedMovieParams(event.id));
    emit(LocalMovieLoaded(movie));
  }

  void onRemoveMovie(RemoveMovie event, Emitter<LocalMoviesState> emit) async {
    await _removeMovie(params: event.movie);
    final movies = await _getSavedMovies();
    emit(LocalMoviesLoaded(movies));
    if (event.movie != null) {
      emit(LocalMovieRemoved(event.movie!));
    }
  }

  void onSaveMovie(SaveMovie event, Emitter<LocalMoviesState> emit) async {
    await _saveMovie(params: event.movie);
    final movies = await _getSavedMovies();
    emit(LocalMoviesLoaded(movies));
    if (event.movie != null) {
      emit(LocalMovieSaved(event.movie!));
    }
  }
}
