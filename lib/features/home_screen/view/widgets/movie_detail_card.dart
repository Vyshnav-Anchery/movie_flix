import 'package:flutter/material.dart';
import 'package:movie_flix/features/home_screen/controller/home_controller.dart';
import 'package:movie_flix/features/movie_details/view/movie_details.dart';
import 'package:provider/provider.dart';

import '../../../../core/movie_details_db.dart';

class MovieDetailTile extends StatelessWidget {
  const MovieDetailTile({
    super.key,
    required this.movie,
  });

  final MovieDetailsDb movie;

  @override
  Widget build(BuildContext context) {
    HomeController provider = Provider.of(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetails(movie: movie),
            ));
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height / 4,
          width: MediaQuery.sizeOf(context).width / 3,
          child: Image.network(
            provider.imagePath + movie.imageUrl,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 230,
              child: Text(
                movie.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                softWrap: true,
              ),
            ),
            // Text(movie.originalTitle!),
            SizedBox(
                width: 230,
                child: Text(
                  movie.overView,
                  softWrap: true,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        )
      ]),
    );
  }
}
