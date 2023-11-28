import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/movie_detail_controller.dart';

class MovieDetails extends StatelessWidget {
  final movie;
  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    MovieDetailsController movieDetailController =
        Provider.of(context, listen: false);
    var releaseDate = DateFormat('MMMM dd, yyyy').format(movie.releaseDate);
    String avgVote = "${(movie.voteAverage * 10).round()} %";
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),title: const Text("Back")),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(movieDetailController.originalimageUrl +
                        movie.posterPath))),
          ),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height / 10,
            child: Opacity(
              opacity: 0.7,
              child: Container(
                padding: const EdgeInsets.all(25),
                // height: MediaQuery.sizeOf(context).height / 3,
                width: MediaQuery.sizeOf(context).height / 2.5,
                color: Colors.black,
                child: Column(
                  children: [
                    Text(movie.originalTitle,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(releaseDate.toString(),
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.stacked_line_chart,
                            color: Colors.white),
                        const SizedBox(width: 10),
                        Text(avgVote,
                            style: const TextStyle(color: Colors.white))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(movie.overview,
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
