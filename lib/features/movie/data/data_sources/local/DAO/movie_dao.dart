import 'package:floor/floor.dart';
import 'package:flutter_tmdb/features/movie/data/models/movie.dart';

@dao
abstract class MovieDao {
  @Insert()
  Future<void> insertMovie(MovieModel movie);

  @delete
  Future<void> deleteMovie(MovieModel movie);

  @Query('SELECT * FROM movie')
  Future<List<MovieModel>> getMovies();
}
