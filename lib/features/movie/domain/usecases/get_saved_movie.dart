import 'package:flutter_tmdb/core/usecase/usecase.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:flutter_tmdb/features/movie/domain/repository/movie_repository.dart';

class GetSavedMovieUseCase implements UseCase<List<MovieEntity>, void> {
  final MovieRepository _movieRepository;

  GetSavedMovieUseCase(this._movieRepository);

  @override
  Future<List<MovieEntity>> call({void params}) {
    return _movieRepository.getSavedMovies();
  }
}
