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
        body: SafeArea(
          child: SingleChildScrollView(
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<LocalMoviesBloc, LocalMoviesState>(
      builder: (_, state) {
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
          return _myListSection(state.movies);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _myListSection(List<MovieEntity>? movies) {
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
              color: Colors.black,
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
                    return MovieCard(movie: movies[index]);
                  },
                ),
        ),
      ],
    );
  }
}
