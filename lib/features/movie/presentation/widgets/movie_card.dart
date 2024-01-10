import 'package:flutter/material.dart';
import 'package:flutter_tmdb/core/constants/constants.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImage(),
        _buildScore(),
        _buildGradient(),
      ],
    );
  }

  Widget _buildGradient() {
    return Container(
      width: 200,
      height: 300,
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0),
          ],
        ),
      ),
    );
  }

  Widget _buildScore() {
    return Container(
      width: 50,
      margin: const EdgeInsets.only(left: 32, top: 10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.red.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        movie.voteAverage.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage('$tmdbImageUrl${movie.posterPath}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
