import 'package:flutter/material.dart';
import 'package:flutter_tmdb/core/constants/constants.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:ionicons/ionicons.dart';

class MovieHeader extends StatelessWidget {
  final MovieEntity movie;
  final void Function(MovieEntity movie)? onMoviePressed;
  const MovieHeader({super.key, required this.movie, this.onMoviePressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.network(
        '$tmdbImageUrl${movie.posterPath}',
        fit: BoxFit.cover,
        width: double.infinity,
        height: 600,
      ),
      _buildGradient(),
      _buildMovieInfo(),
    ]);
  }

  Widget _buildGradient() {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 240,
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
    ]);
  }

  Widget _buildMovieInfo() {
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
          const SizedBox(height: 4),
          Text(
            movie.overview ?? '',
            overflow: TextOverflow.fade,
            maxLines: 2,
            softWrap: true,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          // detail button
          const SizedBox(height: 20),
          _buildActions()
        ],
      ),
    );
  }

  Widget _buildActions() {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: 40,
        width: 200,
        padding: const EdgeInsets.only(left: 32, right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.shade900,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detail',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Ionicons.arrow_forward_outline,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  _onTap() {
    if (onMoviePressed != null) {
      onMoviePressed!(movie);
    }
  }
}
