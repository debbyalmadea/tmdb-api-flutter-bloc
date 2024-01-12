import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;
  final List<dynamic>? genreIds;

  MovieEntity({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.genreIds,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      overview,
      posterPath,
      voteAverage,
      voteCount,
      releaseDate,
    ];
  }
}
