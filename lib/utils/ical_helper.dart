import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ICalHelper {
  /// Generates an iCal (.ics) file for an absence and opens the share sheet.
  static Future<void> generateICalFile({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required String description,
  }) async {
    try {
      final now = DateTime.now().toUtc();
      final dateFormat = DateFormat("yyyyMMdd'T'HHmmss'Z'");
      final start = dateFormat.format(startDate.toUtc());
      final end = dateFormat.format(endDate.toUtc());
      final created = dateFormat.format(now);

      final icsContent = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//frontend_coding_challenge//Absence iCal//EN
BEGIN:VEVENT
UID:${now.millisecondsSinceEpoch}@frontend_coding_challenge
DTSTAMP:$created
DTSTART:$start
DTEND:$end
SUMMARY:$title
DESCRIPTION:$description
END:VEVENT
END:VCALENDAR
''';

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${title.replaceAll(' ', '_')}.ics';
      final file = File(filePath);
      await file.writeAsString(icsContent);

      // Share the file or open with Outlook, Calendar, etc.
      await Share.shareXFiles([XFile(filePath)], text: "Add to Calendar");

    } catch (e) {
      print('❌ Error generating iCal: $e');
      rethrow;
    }
  }
}
