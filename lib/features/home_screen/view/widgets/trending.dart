import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie_flix/features/home_screen/model/top_movies_model.dart';
import 'package:provider/provider.dart';

import '../../controller/home_controller.dart';
import 'movie_detail_card.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of(context, listen: false);
    return FutureBuilder(
      future: homeController.getTopRatedMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("Error getting data"));
        } else {
          return Consumer<HomeController>(builder: (context, provider, child) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: provider.topRated.length,
              itemBuilder: (context, index) {
                TopResult movie = provider.topRated[index];
                return Slidable(
                    endActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (context) =>provider.deleteTopRated(movie),
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
