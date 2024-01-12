import 'package:flutter_tmdb/core/resources/data_state.dart';
import 'package:flutter_tmdb/core/usecase/usecase.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:flutter_tmdb/features/movie/domain/repository/movie_repository.dart';

class GetMoviesUseCase
    implements UseCase<DataState<List<MovieEntity>>, GetMoviesParams> {
  final MovieRepository _movieRepository;

  GetMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<List<MovieEntity>>> call({GetMoviesParams? params}) {
    return _movieRepository.getMovies(params ?? GetMoviesParams());
  }
}
