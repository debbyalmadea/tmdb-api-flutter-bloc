import 'package:equatable/equatable.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';

abstract class LocalMoviesState extends Equatable {
  final List<MovieEntity>? movies;

  const LocalMoviesState({this.movies});

  @override
  List<Object> get props => [movies ?? []];
}

class LocalMoviesLoading extends LocalMoviesState {
  const LocalMoviesLoading();
}

class LocalMoviesLoaded extends LocalMoviesState {
  const LocalMoviesLoaded(List<MovieEntity> movies) : super(movies: movies);
}

class LocalMovieLoading extends LocalMoviesState {
  const LocalMovieLoading();
}

class LocalMovieLoaded extends LocalMoviesState {
  LocalMovieLoaded(MovieEntity? movie)
      : super(movies: movie != null ? [movie] : []);
}

class LocalMovieSaved extends LocalMoviesState {
  LocalMovieSaved(MovieEntity movie) : super(movies: [movie]);
}

class LocalMovieRemoved extends LocalMoviesState {
  LocalMovieRemoved(MovieEntity movie) : super(movies: [movie]);
}
