import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_bloc.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_event.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_state.dart';
import 'package:flutter_tmdb/features/movie/presentation/widgets/movie_card.dart';
import 'package:flutter_tmdb/injection_container.dart';

class MyList extends StatelessWidget {
  const MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalMoviesBloc>(
      create: (context) => sl()..add(const GetSavedMovies()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<LocalMoviesBloc, LocalMoviesState>(
      builder: (context, state) {
        if (state is LocalMoviesLoading) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        if (state is LocalMoviesLoaded) {
          return _myListSection(state.movies, context);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _myListSection(List<MovieEntity>? movies, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            'My List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        movies == null
            ? const Text(
                'No movie',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              )
            : GridView.count(
                padding: const EdgeInsets.only(right: 20),
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
                physics: const NeverScrollableScrollPhysics(),
                children: movies
                    .map((movie) => MovieCard(
                          movie: movie,
                          onMoviePressed: (movie) =>
                              _onMoviePressed(context, movie),
                          width: 190,
                          height: 285,
                        ))
                    .toList(),
              ),
      ],
    );
  }

  void _onMoviePressed(BuildContext context, MovieEntity movie) {
    Navigator.pushNamed(context, '/movie-detail', arguments: movie);
  }
}
