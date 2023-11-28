import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie_flix/features/home_screen/controller/home_controller.dart';
import 'package:movie_flix/features/home_screen/model/playing_now_model.dart';
import 'package:movie_flix/features/home_screen/view/widgets/movie_detail_card.dart';
import 'package:provider/provider.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of(context, listen: false);
    return FutureBuilder(
      future: homeController.getNowPlaying(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("Error getting data"));
        } else {
          return Consumer<HomeController>(builder: (context, provider, child) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: provider.nowPlaying.length,
              itemBuilder: (context, index) {
                Result movie = provider.nowPlaying[index];
                return Slidable(
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (context) =>
                            provider.deleteNowPlaying(movie),
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ]),
                    child: MovieDetailTile(movie: movie));
              },
            );
          });
        }
      },
    );
  }
}
