import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:frontend_coding_challenge/viewmodels/controllers/absence_controller.dart';

/// This test is a pure logic/unit test
  // Ensures the mapping of display names to internal codes is correct.
  // Ensures the leave types list reflects all keys in the controller.

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Needed for GetX

  late AbsencesController controller;

  setUp(() {
    Get.testMode = true; // Enable GetX test mode
    controller = AbsencesController();
  });

  group('AbsencesController leave type tests', () {
    test('leaveTypes list returns all keys', () {
      final expectedKeys = ["Sick Leave", "Vacation"];
      expect(controller.leaveTypes, expectedKeys);
    });

    test('typeValue returns correct mapped values', () {
      expect(controller.typeValue("Sick Leave"), "sickness");
      expect(controller.typeValue("Vacation"), "vacation");
      expect(controller.typeValue("Unknown"), null); // Non-existing key
      expect(controller.typeValue(null), null); // Null input
    });
  });
}
