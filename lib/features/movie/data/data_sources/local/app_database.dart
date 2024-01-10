import 'package:floor/floor.dart';
import 'package:flutter_tmdb/features/movie/data/data_sources/local/DAO/movie_dao.dart';
import 'package:flutter_tmdb/features/movie/data/models/movie.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart';

class StringListConverter extends TypeConverter<List<dynamic>?, String> {
  @override
  List<dynamic> decode(String databaseValue) {
    return databaseValue.split(",").map((e) => int.parse(e)).toList();
  }

  @override
  String encode(List<dynamic>? value) {
    if (value == null) {
      return "";
    }
    return value.join(",");
  }
}

@TypeConverters([StringListConverter])
@Database(version: 1, entities: [MovieModel])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDAO;
}
