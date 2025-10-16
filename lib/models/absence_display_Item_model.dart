class AbsenceDisplayItem {
  final String memberName;
  final String? memberImage;
  final String type;
  final String period;
  final String status;
  final String? memberNote;
  final String? admitterNote;

  AbsenceDisplayItem({
    required this.memberName,
    this.memberImage,
    required this.type,
    required this.period,
    required this.status,
    this.memberNote,
    this.admitterNote,
  });

  /// Returns list of all info lines for easy display
  List<String> getDisplayLines() {
    final lines = [
      "Type: $type",
      "Period: $period",
      "Status: $status",
    ];
    if (memberNote != null && memberNote!.isNotEmpty) {
      lines.add("Member Note: $memberNote");
    }
    if (admitterNote != null && admitterNote!.isNotEmpty) {
      lines.add("Admitter Note: $admitterNote");
    }
    return lines;
  }
}