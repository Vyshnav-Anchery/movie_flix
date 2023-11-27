import 'package:flutter/material.dart';
import 'package:movie_flix/features/home_screen/view/widgets/now_playing.dart';
import 'package:movie_flix/features/home_screen/view/widgets/trending.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.movie),
              text: "Now Playing",
            ),
            Tab(
              icon: Icon(Icons.star_border),
              text: "Top Movies",
            ),
          ]),
          body: const TabBarView(children: [
            NowPlayingMovies(),
            TrendingMovies(),
          ])),
    );
  }
}