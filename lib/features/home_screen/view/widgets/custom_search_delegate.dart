import 'package:flutter/material.dart';
import 'package:movie_flix/features/home_screen/controller/home_controller.dart';
import 'package:movie_flix/features/home_screen/view/widgets/movie_detail_card.dart';
import 'package:provider/provider.dart';
import '../../../../core/movie_details_db.dart';

class CustomSearchDelegate extends SearchDelegate {
  BuildContext ctx;

  CustomSearchDelegate({required this.ctx});

  late TabController tabController = DefaultTabController.of(ctx);

  @override
  String get searchFieldLabel => tabController.index == 0
      ? 'Search in Now Playing...'
      : 'Search in Top Rated...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
 
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(fontSize: 20),
      backgroundColor: Colors.orangeAccent,
    ));
  }

  @override
  Widget buildResults(BuildContext context) {
    HomeController homeScreenController = Provider.of(context, listen: false);

    List<MovieDetailsDb> results = tabController.index == 0
        ? homeScreenController.getNowMovieSearchResult(query)
        : homeScreenController.getTopMovieSearchResult(query);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final MovieDetailsDb movie = results[index];
        return MovieDetailTile(movie: movie);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    HomeController homeScreenController = Provider.of(context, listen: false);
    TabController tabController = DefaultTabController.of(ctx);

    List<MovieDetailsDb> results = tabController.index == 0
        ? homeScreenController.getNowMovieSearchResult(query)
        : homeScreenController.getTopMovieSearchResult(query);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final MovieDetailsDb movie = results[index];
        return MovieDetailTile(movie: movie);
      },
    );
  }
}
