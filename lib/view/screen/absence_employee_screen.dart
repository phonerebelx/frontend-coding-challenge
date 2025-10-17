import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';
import 'package:frontend_coding_challenge/res/colors/colors.dart';
import 'package:frontend_coding_challenge/view/widgets/custom_scaffold.dart';
import 'package:frontend_coding_challenge/view/widgets/employee_detail_card.dart';
import 'package:frontend_coding_challenge/viewmodels/controllers/absence_controller.dart';
import 'package:get/get.dart';

class AbsenceEmployeeScreen extends StatelessWidget {
  AbsenceEmployeeScreen({super.key});

  final AbsencesController controller = Get.put(AbsencesController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Pagination listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !controller.pagingController.isPaginating.value &&
          !controller.pagingController.isLastPage.value) {
        controller.pagingController.loadNextPage();
      }
    });

    return CustomScaffold(
      title: "ABSENCES",
      appBarColor: colors.whiteColor,
      appBarTextColor: colors.blackColor,
      backgroundColor: colors.whiteColor,
      showBackButton: false,
      body: Column(
        children: [
          _buildFilterBar(context),
          const Divider(height: 1),
          // Expanded list
          Expanded(
            child: Obx(() {
              final absences = controller.pagingController.absences;

              if (absences.isEmpty) {
                final status = controller.pagingController.absencesResponse.value.status;
                switch (status) {
                  case Status.LOADING:
                    return const SizedBox.shrink(); // handled by global loader
                  case Status.ERROR:
                    return Center(
                      child: Text(
                        controller.pagingController.absencesResponse.value.message ??
                            "Something went wrong",
                      ),
                    );
                  case Status.EMPTY:
                  case Status.SUCCESS:
                  default:
                    return const Center(child: Text("No absences found"));
                }
              }

              // List with preserved scroll position
              return RefreshIndicator(
                onRefresh: controller.pagingController.refreshList,
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: absences.length,
                  itemBuilder: (context, index) {
                    final item = absences[index];
                    return EmployeeDetailCard(
                      imageUrl: item.memberImage,
                      memberName: item.memberName,
                      type: item.type,
                      period: item.period,
                      status: item.status,
                      memberNote: item.memberNote,
                      admitterNote: item.admitterNote,
                      onGenerateICal: () => controller.generateICalForAbsence(item),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Obx(() {
              List<DropdownMenuItem<String>> dropdownItems = [
                const DropdownMenuItem(
                  value: null,
                  child: Text("All"),
                ),
              ];

              for (var displayName in controller.leaveTypes) {
                dropdownItems.add(
                  DropdownMenuItem(
                    value: controller.typeValue(displayName),
                    child: Text(displayName),
                  ),
                );
              }

              return DropdownButton<String>(
                isExpanded: true,
                hint: const Text("Select Type"),
                value: controller.pagingController.selectedType.value.isNotEmpty
                    ? controller.pagingController.selectedType.value
                    : null,
                items: dropdownItems,
                onChanged: (value) {
                  controller.pagingController.applyFilters(type: value);
                },
              );
            }),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                controller.pagingController.applyFilters(
                  start: picked.start,
                  end: picked.end,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
