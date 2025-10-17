import 'package:get/get.dart';
import 'package:frontend_coding_challenge/models/absence_display_Item_model.dart';
import 'package:frontend_coding_challenge/repository/absences_pagination_repository.dart';
import 'package:frontend_coding_challenge/network/response/api_response.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';

class AbsencesPagingController extends GetxController {
  final AbsencesPaginationRepository repository;

  AbsencesPagingController({required this.repository});

  // Observables
  final RxList<AbsenceDisplayItem> absences = <AbsenceDisplayItem>[].obs;
  final Rx<ApiResponse<List<AbsenceDisplayItem>>> absencesResponse =
      ApiResponse<List<AbsenceDisplayItem>>(Status.LOADING, [], null).obs;

  final RxBool isPaginating = false.obs;
  final RxBool isLastPage = false.obs;
  final RxInt currentPage = 0.obs;
  final int pageSize = 10;

  // Filters
  final RxString selectedType = ''.obs;
  final Rxn<DateTime> startDate = Rxn<DateTime>();
  final Rxn<DateTime> endDate = Rxn<DateTime>();

  /// Load first page
  Future<void> loadFirstPage() async {
    absences.clear();
    currentPage.value = 0;
    isLastPage.value = false;
    absencesResponse.value = ApiResponse.loading(message: "Loading absences...");
    await _loadPage(isInitial: true);
  }

  /// Load next page when scrolling
  Future<void> loadNextPage() async {
    if (isPaginating.value || isLastPage.value) return;

    isPaginating.value = true;
    absencesResponse.value = ApiResponse.loading(message: "Loading absences...");

    try {
      await _loadPage(isInitial: false);
    } catch (e) {
      absencesResponse.value = ApiResponse.error(message: "Error: $e");
    } finally {
      isPaginating.value = false;
      absencesResponse.value =
          ApiResponse.success(data: absences.toList(), message: "Loaded successfully");
    }
  }

  Future<void> _loadPage({required bool isInitial}) async {
    final newItems = await repository.fetchAbsencesPage(
      pageKey: currentPage.value * pageSize,
      type: selectedType.value.isNotEmpty ? selectedType.value : null,
      startDate: startDate.value,
      endDate: endDate.value,
    );

    if (newItems.isEmpty) {
      isLastPage.value = true;
      if (isInitial) {
        absencesResponse.value = ApiResponse.empty(message: "No absences found");
      }
      return;
    }

    absences.addAll(newItems);
    currentPage.value++;
    if (await repository.isLastPage(currentPage.value * pageSize)) {
      isLastPage.value = true;
    }

    if (isInitial) {
      absencesResponse.value =
          ApiResponse.success(data: absences.toList(), message: "Loaded successfully");
    }
  }

  Future<void> refreshList() async {
    await loadFirstPage();
  }

  /// Apply filters
  void applyFilters({String? type, DateTime? start, DateTime? end}) {
    if (type == null || type.isEmpty) {
      // "All" selected
      selectedType.value = '';
    } else {
      selectedType.value = type.toLowerCase();
    }
    startDate.value = start;
    endDate.value = end;
    loadFirstPage();
  }

}
