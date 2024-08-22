import "package:auto_route/auto_route.dart";

// TODO(simon-the-shark): adjust this settings if desired
abstract class TransitionsConfig {
  static const durationInMiliseconds = 200;
  static const slideLeftBuilder = TransitionsBuilders.slideLeft;
  static const slideRightBuilder = TransitionsBuilders.slideRight;
}
