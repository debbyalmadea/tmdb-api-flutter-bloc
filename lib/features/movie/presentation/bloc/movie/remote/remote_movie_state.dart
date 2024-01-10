import 'package:equatable/equatable.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';

abstract class RemoteMoviesState extends Equatable {
  final List<MovieEntity>? movies;
  final Exception? exception;

  const RemoteMoviesState({this.movies, this.exception});

  @override
  List<Object?> get props => [movies, exception];
}

class RemoteMoviesLoading extends RemoteMoviesState {}

class RemoteMoviesLoaded extends RemoteMoviesState {
  const RemoteMoviesLoaded(List<MovieEntity> movies) : super(movies: movies);
}

class RemoteMoviesException extends RemoteMoviesState {
  const RemoteMoviesException(Exception exception)
      : super(exception: exception);
}
