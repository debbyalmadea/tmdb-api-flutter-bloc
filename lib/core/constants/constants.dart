import 'package:flutter_dotenv/flutter_dotenv.dart';

const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
const String tmdbImageUrl = 'https://image.tmdb.org/t/p/original';
String tmdbServiceApiKey = dotenv.env['TMDB_API_KEY'] ?? '';
const String languageQuery = 'en-US';
const bool includeVideoQuery = false;
const bool includeAdultQuery = true;
