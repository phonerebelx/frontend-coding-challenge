import 'package:get/get.dart';
import 'package:frontend_coding_challenge/repository/absences_pagination_repository.dart';
import 'absences_paging_controller.dart';

class AbsencesController extends GetxController {
  late final AbsencesPagingController pagingController;

//  Map for UI display
  final Map<String, String> leaveTypesMap = {
    "Sick Leave": "sickness",
    "Vacation": "vacation",
  };

// Helper to get user-friendly names
  List<String> get leaveTypes => leaveTypesMap.keys.toList();

  @override
  void onInit() {
    super.onInit();
    pagingController = AbsencesPagingController(
      repository: AbsencesPaginationRepository(),
    );
    pagingController.loadFirstPage();
  }

  String? typeValue(String? displayName) {
    if (displayName == null) return null;
    return leaveTypesMap[displayName];
  }

}
