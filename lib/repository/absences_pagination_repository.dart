import 'package:frontend_coding_challenge/models/absence_display_Item_model.dart';
import 'package:frontend_coding_challenge/models/absences_model.dart';
import 'package:frontend_coding_challenge/models/members_model.dart';
import 'package:frontend_coding_challenge/repository/employee_absence_repository.dart';


class AbsencesPaginationRepository {
  static const int pageSize = 10;

  Future<List<AbsenceDisplayItem>> fetchAbsencesPage({required int pageKey}) async {
    // Simulate local JSON delay
    await Future.delayed(const Duration(milliseconds: 500));

    final absencesData = await absences(); // JSON
    final membersData = await members();   // JSON

    final absencesList = absencesData.map((e) => Payload.fromJson(e)).toList();
    final membersList = membersData.map((e) => MemberPayload.fromJson(e)).toList();

    // Map Payload + MemberPayload to AbsenceDisplayItem
    final combinedList = absencesList.map((absence) {
      final member = membersList.firstWhere(
            (m) => m.userId == absence.userId,
        orElse: () => MemberPayload(name: "Unknown"),
      );

      final status = getStatus(absence);

      final period = "${absence.startDate ?? "-"} to ${absence.endDate ?? "-"}";

      return AbsenceDisplayItem(
        memberName: member.name ?? "Unknown",
        memberImage: member.image,
        type: absence.type ?? "-",
        period: period,
        status: status,
        memberNote: absence.memberNote,
        admitterNote: absence.admitterNote,
      );
    }).toList();

    // Pagination slice
    final start = pageKey;
    final end = (pageKey + pageSize) < combinedList.length
        ? pageKey + pageSize
        : combinedList.length;

    return combinedList.sublist(start, end);
  }

  Future<bool> isLastPage(int pageKey) async {
    final absencesData = await absences();
    return pageKey + pageSize >= absencesData.length;
  }

  String getStatus(Payload absence) {
    if (absence.rejectedAt != null) return "Rejected";
    if (absence.confirmedAt != null) return "Confirmed";
    return "Requested";
  }
}
