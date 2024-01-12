import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_bloc.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_state.dart';
import 'package:flutter_tmdb/features/movie/presentation/widgets/movie_card.dart';
import 'package:flutter_tmdb/features/movie/presentation/widgets/movie_header.dart';
import 'package:ionicons/ionicons.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(child: _buildBody()),
    );
  }

  Column _movieListSection(List<MovieEntity>? movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            'Trending Now',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: movies == null
              ? const Text('No movie')
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: movies[index],
                      onMoviePressed: (movie) =>
                          _onMoviePressed(context, movie),
                    );
                  },
                ),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteMoviesBloc, RemoteMoviesState>(
      builder: (context, state) {
        if (state is RemoteMoviesLoading) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        if (state is RemoteMoviesException) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }

        if (state is RemoteMoviesLoaded) {
          var random = Random(state.movies?.length ?? 0);
          var randomMovie =
              state.movies?[random.nextInt(state.movies?.length ?? 0)];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              randomMovie != null
                  ? MovieHeader(
                      movie: randomMovie,
                      onMoviePressed: (movie) {
                        _onMoviePressed(context, movie);
                      })
                  : const SizedBox.shrink(),
              _movieListSection(state.movies),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Ionicons.menu_outline,
          color: Colors.white,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => {},
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onMoviePressed(BuildContext context, MovieEntity movie) {
    Navigator.pushNamed(context, '/movie-detail', arguments: movie);
  }
}
