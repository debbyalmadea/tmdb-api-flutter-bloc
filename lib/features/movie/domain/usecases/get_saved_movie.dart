import 'package:flutter_tmdb/core/usecase/usecase.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:flutter_tmdb/features/movie/domain/repository/movie_repository.dart';

class GetSavedMovieUseCase extends UseCase<MovieEntity?, GetSavedMovieParams?> {
  final MovieRepository repository;

  GetSavedMovieUseCase(this.repository);

  @override
  Future<MovieEntity?> call({GetSavedMovieParams? params}) {
    return repository.getSavedMovie(params ?? GetSavedMovieParams(0));
  }
}
