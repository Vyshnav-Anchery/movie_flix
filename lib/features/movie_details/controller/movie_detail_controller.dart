import 'package:flutter/widgets.dart';
import 'package:movie_flix/features/home_screen/controller/home_controller.dart';

class MovieDetailsController extends ChangeNotifier {
  final HomeController _homeController = HomeController();
  late String originalimageUrl = _homeController.originalImagePath;
}
