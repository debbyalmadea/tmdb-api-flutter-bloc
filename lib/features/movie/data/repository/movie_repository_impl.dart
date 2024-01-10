import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb/core/constants/constants.dart';
import 'package:flutter_tmdb/core/resources/data_state.dart';
import 'package:flutter_tmdb/features/movie/data/data_sources/local/app_database.dart';
import 'package:flutter_tmdb/features/movie/data/data_sources/remote/tmdb_service.dart';
import 'package:flutter_tmdb/features/movie/data/models/movie.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/sort_by.dart';
import 'package:flutter_tmdb/features/movie/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final TMDBService _tmdbService;
  final AppDatabase _appDatabase;

  MovieRepositoryImpl(this._tmdbService, this._appDatabase);

  @override
  Future<DataState<List<MovieModel>>> getMovies(GetMoviesParams params) async {
    // debugPrint('params: $params');
    try {
      final response = await _tmdbService.getMovies(
        sortBy: params.sortByOption ?? SortByOption.popularityDesc,
        includeAdult: includeAdultQuery,
        includeVideo: includeVideoQuery,
        page: params.page ?? 1,
        language: languageQuery,
      );

      if (response.statusCode == HttpStatus.ok) {
        List<MovieModel> movies = [];
        var jsonResponse = jsonDecode(response.body);

        jsonResponse['results'].forEach((movie) {
          movies.add(MovieModel.fromJson(movie));
        });

        return DataSuccess(movies);
      } else {
        return DataFailed(Exception(
            'Failed to load movies. Status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      debugPrintStack(stackTrace: e.stackTrace);
      return DataFailed(e);
    }
  }

  @override
  Future<List<MovieModel>> getSavedMovies() {
    return _appDatabase.movieDAO.getMovies();
  }

  @override
  Future<void> removeMovie(MovieEntity movie) {
    return _appDatabase.movieDAO.deleteMovie(MovieModel.fromEntity(movie));
  }

  @override
  Future<void> saveMovie(MovieEntity movie) {
    return _appDatabase.movieDAO.insertMovie(MovieModel.fromEntity(movie));
  }
}
