import 'package:flutter_tmdb/core/constants/constants.dart';
import 'package:http/http.dart';

class TMDBService {
  Future<Response> getMovies({
    String? language,
    int? page,
    bool? includeAdult,
    bool? includeVideo,
    String? sortBy,
  }) async {
    var queryParams = {
      'language': language ?? languageQuery,
      'page': page?.toString() ?? '1',
      'include_adult': includeAdult?.toString() ?? 'false',
      'include_video': includeVideo?.toString() ?? 'false',
      'sort_by': sortBy ?? '',
    };

    return await get(
      Uri.parse(
          '$tmdbBaseUrl/discover/movie?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}'),
      headers: {
        'Authorization': 'Bearer $tmdbServiceApiKey',
      },
    );
  }
}
