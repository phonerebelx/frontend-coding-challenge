import 'package:frontend_coding_challenge/models/absence_display_Item_model.dart';
import 'package:get/get.dart';
import 'package:frontend_coding_challenge/models/members_model.dart';
import 'package:frontend_coding_challenge/models/absences_model.dart';
import 'package:frontend_coding_challenge/network/response/api_response.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';
import 'dart:async';

import '../../repository/employee_absence_repository.dart';

class AbsencesController extends GetxController {
  Rx<ApiResponse<List<AbsenceDisplayItem>>> apiResponse =
      ApiResponse<List<AbsenceDisplayItem>>(Status.LOADING, null, null).obs;

  @override
  void onInit() {
    super.onInit();
    loadAbsencesWithMembers();
  }

  /// Load absences and combine them with members
  Future<void> loadAbsencesWithMembers() async {
    try {
      apiResponse.value = ApiResponse.loading(message: "Loading absences...");

      // Optional artificial delay
      await Future.delayed(const Duration(seconds: 2));

      // Load JSON data
      final absencesData = await absences();
      final membersData = await members();

      final absencesList = absencesData.map((e) => Payload.fromJson(e)).toList();
      final membersList = membersData.map((e) => MemberPayload.fromJson(e)).toList();

      // Combine absences with members and map to display items
      final List<AbsenceDisplayItem> displayList = absencesList.map((a) {
        final member = membersList.firstWhere(
                (m) => m.userId == a.userId,
            orElse: () => MemberPayload(name: "Unknown", image: ""));

        return AbsenceDisplayItem(
          memberName: member.name ?? "Unknown",
          memberImage: member.image,
          type: a.type ?? "",
          period: "${a.startDate} to ${a.endDate}",
          status: getStatus(a),
          memberNote: a.memberNote,
          admitterNote: a.admitterNote,
        );
      }).toList();

      apiResponse.value =
          ApiResponse.success(data: displayList, message: "Absences loaded successfully");

    } catch (e) {
      apiResponse.value = ApiResponse.error(message: "Failed to load absences: $e");
      print("Error loading absences: $e");
    }
  }

  /// Get status of absence
  String getStatus(Payload absence) {
    if (absence.rejectedAt != null) return "Rejected";
    if (absence.confirmedAt != null) return "Confirmed";
    return "Requested";
  }
}

