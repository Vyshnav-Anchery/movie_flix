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
            return const Center(child: Text("Error getting data"));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.results!.length,
              itemBuilder: (context, index) {
                Result movie = snapshot.data!.results![index];
                // return ListTile(
                //   isThreeLine: true,
                //   leading: Image.network(
                //     provider.imagePath + movie.posterPath!,
                //   ),
                //   title: Text(movie.originalTitle!),
                //   subtitle: Text(movie.overview!),
                // );
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 4,
                        width: MediaQuery.sizeOf(context).width / 3,
                        child: Image.network(
                          provider.imagePath + movie.posterPath!,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 230,
                            child: Text(
                              movie.originalTitle!,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              softWrap: true,
                            ),
                          ),
                          // Text(movie.originalTitle!),
                          SizedBox(
                              width: 230,
                              child: Text(
                                movie.overview!,
                                softWrap: true,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ],
                      )
                    ]);
              },
            );
          }
        },
      );
    });
  }
}
