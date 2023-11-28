import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_flix/core/movie_details_db.dart';
import 'package:movie_flix/features/home_screen/controller/home_controller.dart';
import 'package:movie_flix/features/movie_details/controller/movie_detail_controller.dart';
import 'package:movie_flix/utils/app_constants.dart';
import 'package:movie_flix/utils/boxes.dart';
import 'package:movie_flix/utils/pref_variable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home_screen/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  pref = await SharedPreferences.getInstance();

  await Hive.initFlutter();

  Hive.registerAdapter(MovieDetailsDbAdapter());

  await Hive.openBox<MovieDetailsDb>(AppConstants.topMovieBoxName);

  nowPlayingMovieBox = Hive.box<MovieDetailsDb>(AppConstants.topMovieBoxName);

  await Hive.openBox<MovieDetailsDb>(AppConstants.nowPlayingMovieBoxName);

  topMovieBox = Hive.box<MovieDetailsDb>(AppConstants.nowPlayingMovieBoxName);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HomeController(),
    ),
    ChangeNotifierProvider(
      create: (context) => MovieDetailsController(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieFlix',
      debugShowCheckedModeBanner: false,
      theme: AppConstants.appTheme,
      home: const HomePage(),
    );
  }
}
