import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_flix/utils/app_constants.dart';
import 'package:movie_flix/utils/boxes.dart';
import 'package:movie_flix/utils/pref_variable.dart';
import 'package:provider/provider.dart';
import '../../../../core/movie_details_db.dart';
import '../../controller/home_controller.dart';
import 'movie_detail_card.dart';

class TrendingMovies extends StatefulWidget {
  const TrendingMovies({super.key});

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  late HomeController homeController;
  @override
  void didChangeDependencies() {
    homeController = Provider.of(context, listen: false);
    bool fetchTopRated = pref.getBool(AppConstants.FETCHTOPMOVIEKEY) ?? false;
    if (!fetchTopRated) {
      homeController.getTopRatedMovies();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, provider, child) {
      return RefreshIndicator(
        onRefresh: () => provider.getTopRatedMovies(),
        child: ListenableBuilder(
            listenable: topMovieBox.listenable(),
            builder: (context, child) {
              if (topMovieBox.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Top rated list is empty"),
                    TextButton(
                        onPressed: () => provider.getTopRatedMovies(),
                        child: const Text("Tap to refresh"))
                  ],
                ));
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: topMovieBox.values.length,
                  itemBuilder: (context, index) {
                    // TopResult movie = provider.topRated[index];
                    MovieDetailsDb? movies = topMovieBox.getAt(index);
                    return Slidable(
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) =>
                                provider.deleteTopRated(index),
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ]),
                        child: MovieDetailTile(movie: movies!));
                  },
                );
              }
            }),
      );
    });
  }
}
