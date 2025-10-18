import 'package:get/get.dart';
import 'package:frontend_coding_challenge/res/routes/routes_name.dart';

class SplashController extends GetxController {
  final int splashDurationSeconds;

  SplashController({this.splashDurationSeconds = 2});

  @override
  void onInit() {
    super.onInit();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    Future.delayed(Duration(seconds: splashDurationSeconds), () {
      _goToAbsenceEmployeeScreen();
    });
  }

  void _goToAbsenceEmployeeScreen() {
    // Navigate using route name
    Get.offAllNamed(RoutesName.absenceEmployeeScreen);
  }
}
