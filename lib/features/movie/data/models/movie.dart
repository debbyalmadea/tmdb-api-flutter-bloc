import 'package:floor/floor.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';

@Entity(tableName: 'movie', primaryKeys: ['id'])
class MovieModel extends MovieEntity {
  const MovieModel({
    super.id,
    super.title,
    super.overview,
    super.posterPath,
    super.voteAverage,
    super.voteCount,
    super.releaseDate,
    super.genreIds,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    var voteAverage = json['vote_average'];
    if (voteAverage is int) {
      voteAverage = voteAverage.toDouble();
    }

    var voteCount = json['vote_count'];
    if (voteCount is String) {
      voteCount = int.parse(voteCount);
    } else if (voteCount is double) {
      voteCount = voteCount.toInt();
    }

    return MovieModel(
      id: json['id'],
      title: json['title'] ?? "",
      overview: json['overview'] ?? "",
      posterPath: json['poster_path'] ?? "",
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: json['release_date'] ?? "",
      genreIds: json['genre_ids'] ?? [],
    );
  }

  factory MovieModel.fromEntity(MovieEntity entity) {
    return MovieModel(
      id: entity.id,
      title: entity.title,
      overview: entity.overview,
      posterPath: entity.posterPath,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
      releaseDate: entity.releaseDate,
      genreIds: entity.genreIds,
    );
  }

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, overview: $overview, posterPath: $posterPath, voteAverage: $voteAverage, voteCount: $voteCount, releaseDate: $releaseDate, genreIds: $genreIds)';
  }
}
