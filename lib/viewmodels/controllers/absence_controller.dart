import 'dart:io';
import 'package:frontend_coding_challenge/models/absence_display_Item_model.dart';
import 'package:frontend_coding_challenge/repository/absences_pagination_repository.dart';
import 'package:frontend_coding_challenge/utils/ical_helper.dart';
import 'package:frontend_coding_challenge/network/response/api_response.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'absences_paging_controller.dart';

class AbsencesController extends GetxController {
  late final AbsencesPagingController pagingController;

  final Rx<ApiResponse<void>> icalResponse =
      ApiResponse<void>(Status.SUCCESS, null, null).obs;

  // Map for UI display
  final Map<String, String> leaveTypesMap = {
    "Sick Leave": "sickness",
    "Vacation": "vacation",
  };

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

  /// Generate an iCal (.ics) file for the given absence item
  Future<void> generateICalForAbsence(AbsenceDisplayItem item) async {
    try {
      // Start loader
      icalResponse.value = ApiResponse.loading(message: "Generating iCal file...");

      // Parse start and end dates
      final parts = item.period.split("to");
      final startDate = DateTime.tryParse(parts.first.trim()) ?? DateTime.now();
      final endDate = parts.length > 1
          ? DateTime.tryParse(parts.last.trim()) ?? startDate.add(const Duration(days: 1))
          : startDate.add(const Duration(days: 1));

      // Generate the file
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/${item.memberName} - ${item.type}';
      final file = File(path);

      final content = '''
BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
SUMMARY:${item.memberName} - ${item.type}
DTSTART:${startDate.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '')}
DTEND:${endDate.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '')}
DESCRIPTION:Status: ${item.status}\nType: ${item.type}\nPeriod: ${item.period}\nNotes: ${item.memberNote ?? ''}
END:VEVENT
END:VCALENDAR
''';

      await file.writeAsString(content);


      // Trigger share (don't await)
      Share.shareXFiles([XFile(path)], text: "Here’s iCal event");

      // Hide loader immediately after file creation
      icalResponse.value = ApiResponse.success(message: "iCal file generated successfully!");

    } catch (e) {
      icalResponse.value = ApiResponse.error(message: "Error generating iCal: $e");
    }
  }

}
