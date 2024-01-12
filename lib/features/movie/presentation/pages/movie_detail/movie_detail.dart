import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/core/constants/constants.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_bloc.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_event.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/local/local_movie_state.dart';
import 'package:flutter_tmdb/injection_container.dart';
import 'package:ionicons/ionicons.dart';

class MovieDetail extends StatelessWidget {
  final MovieEntity movie;
  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalMoviesBloc>()..add(GetSavedMovie(movie.id ?? 0)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Stack(
              children: [
                _buildBackground(),
                _buildGradient(),
                _buildTitle(),
              ],
            ),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBackground() {
    return Image.network(
      '$tmdbImageUrl${movie.posterPath}',
      fit: BoxFit.cover,
      width: double.infinity,
      height: 450,
    );
  }

  Widget _buildGradient() {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(0),
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 450,
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
    ]);
  }

  Widget _buildTitle() {
    return Positioned(
      bottom: 30,
      left: 20,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title ?? '',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.releaseDate ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(builder: (context) => _actionButton(context)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildRatingIndicator(value: movie.voteAverage ?? 0.0),
              const SizedBox(width: 8),
              Text(
                '${movie.voteCount} Ratings',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            movie.overview ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingIndicator({
    required double value,
  }) {
    double halfValue = value / 2 - 1;
    return Row(
      children: [
        ...List.generate(
          5,
          (index) => Icon(
            Icons.star,
            color: index < halfValue
                ? Colors.red
                : const Color.fromARGB(255, 157, 137, 137),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _actionButton(BuildContext context) {
    return BlocBuilder<LocalMoviesBloc, LocalMoviesState>(
        builder: (context, state) {
      // debugPrint('state: $state');
      if (state is LocalMovieLoaded) {
        final isSaved = state.movies != null && state.movies!.contains(movie);
        return isSaved
            ? _removeFromMyListButton(context)
            : _addToMyListButton(context);
      }
      if (state is LocalMovieSaved) {
        if (state.movies != null && state.movies!.contains(movie)) {
          return _removeFromMyListButton(context);
        }
      }
      if (state is LocalMovieRemoved) {
        if (state.movies != null && state.movies!.contains(movie)) {
          return _addToMyListButton(context);
        }
      }
      if (state is LocalMoviesLoading) {
        return const SizedBox();
      }
      return const SizedBox();
    });
  }

  Widget _removeFromMyListButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _removeMovieFromMyList(context),
      child: Container(
        height: 40,
        width: 160,
        padding: const EdgeInsets.only(left: 24, right: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Ionicons.checkmark,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              'My List',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addToMyListButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _addMovieToMyList(context),
      child: Container(
        height: 40,
        width: 160,
        padding: const EdgeInsets.only(left: 24, right: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Ionicons.add,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'My List',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addMovieToMyList(BuildContext context) {
    BlocProvider.of<LocalMoviesBloc>(context).add(SaveMovie(movie));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade900,
        content: const Text(
          'Added to My List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _removeMovieFromMyList(BuildContext context) {
    BlocProvider.of<LocalMoviesBloc>(context).add(RemoveMovie(movie));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade900,
        content: const Text(
          'Removed from My List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
