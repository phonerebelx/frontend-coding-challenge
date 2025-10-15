import 'package:frontend_coding_challenge/res/routes/routes_name.dart';
import 'package:frontend_coding_challenge/view/screen/absence_employee_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoute() => [
    GetPage(
      name: RoutesName.absenceEmployeeScreen,
      page: () => AbsenceEmployeeScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
