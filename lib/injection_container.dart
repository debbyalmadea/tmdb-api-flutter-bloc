import 'package:dio/dio.dart';
import 'package:flutter_tmdb/features/movie/data/data_sources/local/app_database.dart';
import 'package:flutter_tmdb/features/movie/data/data_sources/remote/tmdb_service.dart';
import 'package:flutter_tmdb/features/movie/data/repository/movie_repository_impl.dart';
import 'package:flutter_tmdb/features/movie/domain/repository/movie_repository.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/get_movies.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/get_saved_movie.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/get_saved_movies.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/remove_movie.dart';
import 'package:flutter_tmdb/features/movie/domain/usecases/save_movie.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_bloc.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Dependencies
  sl.registerSingleton<MovieRepository>(
      MovieRepositoryImpl(TMDBService(), sl()));

  //UseCases
  sl.registerSingleton<GetMoviesUseCase>(GetMoviesUseCase(sl()));

  sl.registerSingleton<GetSavedMoviesUseCase>(GetSavedMoviesUseCase(sl()));

  sl.registerSingleton<SaveMovieUseCase>(SaveMovieUseCase(sl()));

  sl.registerSingleton<RemoveMovieUseCase>(RemoveMovieUseCase(sl()));

  sl.registerSingleton<GetSavedMovieUseCase>(GetSavedMovieUseCase(sl()));

  //Blocs
  sl.registerFactory<RemoteMoviesBloc>(() => RemoteMoviesBloc(sl()));

  sl.registerFactory<LocalMoviesBloc>(
      () => LocalMoviesBloc(sl(), sl(), sl(), sl()));
}
