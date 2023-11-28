import 'package:flutter/material.dart';
import 'package:movie_flix/features/home_screen/view/widgets/custom_search_delegate.dart';
import 'package:movie_flix/features/home_screen/view/widgets/now_playing.dart';
import 'package:movie_flix/features/home_screen/view/widgets/trending.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  // showSearch(
                  //     context: context, delegate: CustomSearchDelegate());
                },
                icon: const Icon(Icons.search)),
          ),
          bottomNavigationBar: const TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.blueGrey,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  icon: Icon(Icons.video_collection),
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
