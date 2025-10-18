import 'package:frontend_coding_challenge/view/screen/absence_employee_screen.dart';
import 'package:frontend_coding_challenge/view/screen/splash_screen.dart';
import 'package:frontend_coding_challenge/res/routes/routes_name.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoute() => [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RoutesName.absenceEmployeeScreen,
      page: () => AbsenceEmployeeScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
