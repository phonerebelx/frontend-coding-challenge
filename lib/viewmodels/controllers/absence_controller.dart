import 'package:get/get.dart';
import 'package:frontend_coding_challenge/repository/absences_pagination_repository.dart';
import 'absences_paging_controller.dart';

class AbsencesController extends GetxController {
  late final AbsencesPagingController pagingController;

  @override
  void onInit() {
    super.onInit();
    pagingController = AbsencesPagingController(
      repository: AbsencesPaginationRepository(),
    );
    pagingController.loadFirstPage();
  }
}
