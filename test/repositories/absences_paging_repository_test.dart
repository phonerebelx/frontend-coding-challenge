import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:frontend_coding_challenge/viewmodels/controllers/absences_paging_controller.dart';
import 'package:frontend_coding_challenge/models/absence_display_Item_model.dart';
import 'package:frontend_coding_challenge/repository/absences_pagination_repository.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';

/// This test file focuses on controller logic, specifically:
  // Pagination – loading first and next pages correctly.
  // Filtering – applying type filters works as expected.
  // Refresh – resets list to first page.
  // Controller state – updates observables like currentPage, isLastPage, absencesResponse

class FakeAbsencesRepository extends AbsencesPaginationRepository {
  final List<AbsenceDisplayItem> items;
  final bool lastPage;

  FakeAbsencesRepository({required this.items, this.lastPage = false});

  @override
  Future<List<AbsenceDisplayItem>> fetchAbsencesPage({
    required int pageKey,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Return only pageSize items starting from pageKey
    final pageSize = 10;
    final pagedItems = items.skip(pageKey).take(pageSize).toList();

    // Apply type filter
    if (type != null && type.isNotEmpty) {
      return pagedItems.where((e) => e.type.toLowerCase() == type).toList();
    }
    return pagedItems;
  }

  @override
  Future<bool> isLastPage(int offset) async {
    return lastPage || offset >= items.length;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AbsencesPagingController controller;
  late FakeAbsencesRepository repository;

  final mockItems = List.generate(
      15,
          (index) => AbsenceDisplayItem(
        memberName: "User $index",
        type: index % 2 == 0 ? "Sick Leave" : "Vacation",
        period: "2025-10-20 to 2025-10-21",
        status: "Requested",
      ));

  setUp(() {
    Get.testMode = true;
    repository = FakeAbsencesRepository(items: mockItems);
    controller = AbsencesPagingController(repository: repository);
  });

  test('loadFirstPage loads initial items', () async {
    await controller.loadFirstPage();

    expect(controller.absences.length, 10);
    expect(controller.currentPage.value, 1);
    expect(controller.isLastPage.value, false);
    expect(controller.absencesResponse.value.status, Status.SUCCESS);
  });

  test('loadNextPage loads next set of items', () async {
    await controller.loadFirstPage();
    await controller.loadNextPage();

    expect(controller.absences.length, 15); // 10 + 5 remaining
    expect(controller.currentPage.value, 2);
    expect(controller.isLastPage.value, true);
  });

  test('applyFilters filters items by type', () async {
    controller.applyFilters(type: "Sick Leave");
    await Future.delayed(const Duration(milliseconds: 100)); // wait for async

    // Only Sick Leave items
    expect(controller.absences.every((e) => e.type == "Sick Leave"), true);
  });

  test('refreshList reloads first page', () async {
    await controller.loadFirstPage();
    await controller.loadNextPage();

    await controller.refreshList();
    expect(controller.absences.length, 10);
    expect(controller.currentPage.value, 1);
    expect(controller.isLastPage.value, false);
  });
}
