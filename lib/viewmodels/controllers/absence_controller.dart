import 'package:frontend_coding_challenge/models/absence_display_Item_model.dart';
import 'package:frontend_coding_challenge/repository/absences_pagination_repository.dart';
import 'package:frontend_coding_challenge/utils/ical_helper.dart';
import 'package:frontend_coding_challenge/network/response/api_response.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';
import 'package:get/get.dart';

import 'absences_paging_controller.dart';

class AbsencesController extends GetxController {
  late final AbsencesPagingController pagingController;

  final Rx<ApiResponse<void>> icalResponse = ApiResponse<void>(Status.SUCCESS, null, null).obs;

  // Map for UI display
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

  // Generate an iCal (.ics) file for the given absence item
  Future<void> generateICalForAbsence(AbsenceDisplayItem item) async {
    try {
      // Show global loader
      icalResponse.value = ApiResponse.loading(message: "Generating iCal file...");

      // Parse start and end dates
      final parts = item.period.split("to");
      final startDate = DateTime.tryParse(parts.first.trim()) ?? DateTime.now();
      final endDate = parts.length > 1
          ? DateTime.tryParse(parts.last.trim()) ??
          startDate.add(const Duration(days: 1))
          : startDate.add(const Duration(days: 1));

      // Generate file
      await ICalHelper.generateICalFile(
        title: "${item.memberName} - ${item.type}",
        startDate: startDate,
        endDate: endDate,
        description:
        "Status: ${item.status}\nType: ${item.type}\nPeriod: ${item.period}\nNotes: ${item.memberNote ?? ''}",
      );

      // Success → Hide loader
      icalResponse.value = ApiResponse.success(message: "iCal file generated successfully!");
    } catch (e) {
      // Error → Hide loader with message
      icalResponse.value = ApiResponse.error(message: "Error generating iCal: $e");
    }
  }
}
