import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_screen_controller.g.dart';

Future<void> _initializationLogic() async {
  /*
      Insert here any initialization async logic or operations 
      to be performed, when SplashScreen is showed.
  */
}

@riverpod
Future<void> splashScreenController(
    SplashScreenControllerRef ref, Duration additionalWaitDuration) async {
  await _initializationLogic();
  await Future.delayed(additionalWaitDuration);
}
