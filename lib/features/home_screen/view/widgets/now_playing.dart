import 'package:flutter/material.dart';
import 'package:movie_flix/features/home_screen/controller/home_controller.dart';
import 'package:movie_flix/features/home_screen/model/playing_now_model.dart';
import 'package:provider/provider.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, provider, child) {
      return FutureBuilder(
        future: provider.getNowPlaying(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("Error getting data"));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.totalResults!,
              itemBuilder: (context, index) {
                Result movie = snapshot.data!.results![index];
                return ListTile(
                  leading:
                      Image.network(provider.imagePath + movie.posterPath!),
                );
              },
            );
          }
        },
      );
    });
  }
}
