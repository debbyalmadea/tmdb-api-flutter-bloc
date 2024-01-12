import 'package:flutter_tmdb/core/resources/data_state.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';

class GetMoviesParams {
  final int? page;
  final String? sortByOption;

  GetMoviesParams({this.page, this.sortByOption});
}

class GetSavedMovieParams {
  final int id;

  GetSavedMovieParams(this.id);
}

abstract class MovieRepository {
  Future<DataState<List<MovieEntity>>> getMovies(GetMoviesParams params);

  Future<List<MovieEntity>> getSavedMovies();

  Future<MovieEntity?> getSavedMovie(GetSavedMovieParams params);

  Future<void> saveMovie(MovieEntity movie);

  Future<void> removeMovie(MovieEntity movie);
}
