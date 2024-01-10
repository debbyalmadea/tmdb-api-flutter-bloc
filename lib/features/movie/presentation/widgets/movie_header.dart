import 'package:flutter/material.dart';
import 'package:flutter_tmdb/core/constants/constants.dart';
import 'package:flutter_tmdb/features/movie/domain/entities/movie.dart';
import 'package:ionicons/ionicons.dart';

class MovieHeader extends StatelessWidget {
  final MovieEntity movie;
  const MovieHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.network(
        '$tmdbImageUrl${movie.posterPath}',
        fit: BoxFit.cover,
        width: double.infinity,
        height: 500,
      ),
      _buildGradient(),
      _buildMovieInfo(),
    ]);
  }

  Widget _buildGradient() {
    return Container(
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
    );
  }

  Widget _buildMovieInfo() {
    return Positioned(
      bottom: 30,
      left: 20,
      width: 320,
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
    return Row(
      children: [
        Container(
          height: 40,
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
        const SizedBox(width: 20),
        Container(
          height: 40,
          padding: const EdgeInsets.only(left: 24, right: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
            color: Colors.transparent,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Ionicons.add_outline,
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
      ],
    );
  }
}
