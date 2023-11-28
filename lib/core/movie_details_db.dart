import 'package:hive_flutter/hive_flutter.dart';
part 'movie_details_db.g.dart';

@HiveType(typeId: 1)
class MovieDetailsDb extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  DateTime releaseDate;
  @HiveField(3)
  String imageUrl;
  @HiveField(4)
  String overView;
  @HiveField(5)
  double popularity;

  MovieDetailsDb({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.overView,
    required this.popularity,
    required this.releaseDate,
  });
}
