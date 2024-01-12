import 'package:flutter/material.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:flutter_tmdb/features/movie/presentation/pages/home/trending_movies.dart';
import 'package:flutter_tmdb/features/movie/presentation/pages/movie_detail/movie_detail.dart';
import 'package:flutter_tmdb/features/movie/presentation/pages/my_list/my_list.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const TrendingMovies());
      case '/movie-detail':
        return _materialRoute(
            MovieDetail(movie: settings.arguments as MovieEntity));
      case 'my-list':
        return _materialRoute(const MyList());
      default:
        return _materialRoute(const TrendingMovies());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
