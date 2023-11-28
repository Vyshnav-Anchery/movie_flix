import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movie_flix/features/home_screen/model/playing_now_model.dart';
import 'package:movie_flix/features/home_screen/model/top_movies_model.dart';

class HomeController extends ChangeNotifier {
  String nowPlayingUrl =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";

  String topRatedUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";

  String imagePath = "https://image.tmdb.org/t/p/w500/";

  String originalImagePath = "https://image.tmdb.org/t/p/original/";

  List<Result> nowPlaying = [];

  List<TopResult> topRated = [];

  Future<List<TopResult>?> getTopRatedMovies() async {
    try {
      final response = await http.get(Uri.parse(topRatedUrl));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        topRated.clear();
        TopRatedModel topRatedMovies = TopRatedModel.fromJson(data);
        topRated.addAll(topRatedMovies.results!.toList());
        return topRated;
      } else {
        return null;
      }
    } catch (e) {
      log("error ${e.toString()}");
      return null;
    }
  }

  deleteNowPlaying(Result movie) {
    nowPlaying.removeWhere((i) => i.id == movie.id);
    notifyListeners();
  }

  Future<List<Result>?> getNowPlaying() async {
    try {
      final response = await http.get(Uri.parse(nowPlayingUrl));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        nowPlaying.clear();
        NowPlayingModel nowPlayingMovies = NowPlayingModel.fromJson(data);
        nowPlaying.addAll(nowPlayingMovies.results!.toList());
        return nowPlaying;
      } else {
        return null;
      }
    } catch (e) {
      log("error ${e.toString()}");
      return null;
    }
  }

  deleteTopRated(TopResult movie) {
    topRated.removeWhere((element) => element.id == movie.id);
    notifyListeners();
  }
}
