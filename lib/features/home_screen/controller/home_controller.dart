import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movie_flix/core/movie_details_db.dart';
import 'package:movie_flix/features/home_screen/model/playing_now_model.dart';
import 'package:movie_flix/features/home_screen/model/top_movies_model.dart';
import 'package:movie_flix/utils/app_constants.dart';
import 'package:movie_flix/utils/boxes.dart';
import 'package:movie_flix/utils/pref_variable.dart';

class HomeController extends ChangeNotifier {
  String nowPlayingUrl =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";

  String topRatedUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";

  String imagePath = "https://image.tmdb.org/t/p/w500/";

  String originalImagePath = "https://image.tmdb.org/t/p/original/";

  List<Result> nowPlaying = [];

  List<TopResult> topRated = [];

  getTopRatedMovies() async {
    try {
      final response = await http.get(Uri.parse(topRatedUrl));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        topRated.clear();
        TopRatedModel topRatedMovies = TopRatedModel.fromJson(data);
        topRated.addAll(topRatedMovies.results!.toList());
        for (TopResult i in topRated) {
          if (!topMovieBox.values.any((movie) => movie.id == i.id)) {
            topMovieBox
                .add(MovieDetailsDb(
                    id: i.id!,
                    title: i.originalTitle!,
                    imageUrl: i.posterPath!,
                    overView: i.overview!,
                    popularity: i.voteAverage!,
                    releaseDate: i.releaseDate!))
                .then((value) =>
                    pref.setBool(AppConstants.FETCHTOPMOVIEKEY, true));
            log("Add");
          }
        }
      }
    } catch (e) {
      log("error ${e.toString()}");
    }
  }

  deleteNowPlaying(int index) {
    nowPlayingMovieBox.deleteAt(index);
  }

  getNowPlaying() async {
    try {
      final response = await http.get(Uri.parse(nowPlayingUrl));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        nowPlaying.clear();
        NowPlayingModel nowPlayingMovies = NowPlayingModel.fromJson(data);
        nowPlaying.addAll(nowPlayingMovies.results!.toList());
        for (Result i in nowPlaying) {
          if (!nowPlayingMovieBox.values.any((movie) => movie.id == i.id)) {
            nowPlayingMovieBox
                .add(MovieDetailsDb(
                    id: i.id!,
                    title: i.title!,
                    imageUrl: i.posterPath!,
                    overView: i.overview!,
                    popularity: i.voteAverage!,
                    releaseDate: i.releaseDate!))
                .then((value) =>
                    pref.setBool(AppConstants.FETCHNOWPLAYINGMOVIEKEY, true));
          }
        }
      }
    } catch (e) {
      log("error ${e.toString()}");
    }
  }

  deleteTopRated(int index) {
    topMovieBox.deleteAt(index);
  }

  List<MovieDetailsDb> getTopMovieSearchResult(String query) {
    List<MovieDetailsDb> results = topMovieBox.values
        .where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return results;
  }

  List<MovieDetailsDb> getNowMovieSearchResult(String query) {
    List<MovieDetailsDb> results = nowPlayingMovieBox.values
        .where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return results;
  }
}
