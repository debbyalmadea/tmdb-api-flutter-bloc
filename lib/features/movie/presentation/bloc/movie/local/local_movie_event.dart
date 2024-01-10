import 'package:equatable/equatable.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';

abstract class LocalMoviesEvent extends Equatable {
  const LocalMoviesEvent();
}

class GetSavedMovies extends LocalMoviesEvent {
  const GetSavedMovies();

  @override
  List<Object?> get props => [];
}

class RemoveMovie extends LocalMoviesEvent {
  final MovieEntity? movie;
  const RemoveMovie(this.movie);
  @override
  List<Object?> get props => [movie];
}

class SaveMovie extends LocalMoviesEvent {
  final MovieEntity? movie;
  const SaveMovie(this.movie);
  @override
  List<Object?> get props => [movie];
}
