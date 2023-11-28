import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_flix/features/home_screen/controller/home_controller.dart';
import 'package:movie_flix/features/home_screen/view/widgets/movie_detail_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/movie_details_db.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/boxes.dart';
import '../../../../utils/pref_variable.dart';

class NowPlayingMovies extends StatefulWidget {
  const NowPlayingMovies({super.key});

  @override
  State<NowPlayingMovies> createState() => _NowPlayingMoviesState();
}

class _NowPlayingMoviesState extends State<NowPlayingMovies> {
  late HomeController homeController;
  @override
  void didChangeDependencies() {
    homeController = Provider.of(context, listen: false);
    bool fetchNowPlaying =
        pref.getBool(AppConstants.FETCHNOWPLAYINGMOVIEKEY) ?? false;
    if (!fetchNowPlaying) {
      homeController.getNowPlaying();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, provider, child) {
      return RefreshIndicator(
        onRefresh: () => provider.getNowPlaying(),
        child: ListenableBuilder(
            listenable: nowPlayingMovieBox.listenable(),
            builder: (context, child) {
              if (nowPlayingMovieBox.isEmpty) {
                return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Now playing list is empty"),
                    TextButton(
                        onPressed: () => provider.getNowPlaying(),
                        child: const Text("Tap to refresh"))
                  ],
                ));
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: nowPlayingMovieBox.values.length,
                  itemBuilder: (context, index) {
                    MovieDetailsDb? movies = nowPlayingMovieBox.getAt(index);
                    return Slidable(
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) =>
                                provider.deleteNowPlaying(index),
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
