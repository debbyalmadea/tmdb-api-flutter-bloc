import 'package:equatable/equatable.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';

abstract class LocalMoviesState extends Equatable {
  final List<MovieEntity>? movies;

  const LocalMoviesState({this.movies});

  @override
  List<Object> get props => [movies!];
}

class LocalMoviesLoading extends LocalMoviesState {
  const LocalMoviesLoading();
}

class LocalMoviesLoaded extends LocalMoviesState {
  const LocalMoviesLoaded(List<MovieEntity> movies) : super(movies: movies);
}
