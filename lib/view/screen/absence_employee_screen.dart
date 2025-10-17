import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';
import 'package:get/get.dart';
import 'package:frontend_coding_challenge/viewmodels/controllers/absence_controller.dart';

class AbsenceEmployeeScreen extends StatelessWidget {
  AbsenceEmployeeScreen({super.key});

  final AbsencesController controller = Get.put(AbsencesController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !controller.pagingController.isPaginating.value &&
          !controller.pagingController.isLastPage.value) {
        controller.pagingController.loadNextPage();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Absences"), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            _buildFilterBar(context),
            const Divider(height: 1),
            Expanded(
              child: Obx(() {
                final response = controller.pagingController.absencesResponse.value;

                switch (response.status) {
                  case Status.ERROR:
                    return Center(
                      child: Text(response.message ?? "Something went wrong"),
                    );
                  case Status.LOADING:
                    return const Center(
                      child: Text("Loading absence"),
                    );
                  case Status.EMPTY:
                    return const Center(
                      child: Text("No absences found"),
                    );

                  case Status.SUCCESS:
                  default:
                    final absences = response.data ?? [];
                    if (absences.isEmpty) {
                      return const Center(child: Text("No absences found"));
                    }
                    return RefreshIndicator(
                      onRefresh: controller.pagingController.refreshList,
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: absences.length,
                        itemBuilder: (context, index) {
                          final item = absences[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: item.memberImage != null
                                    ? NetworkImage(item.memberImage!)
                                    : null,
                                child: item.memberImage == null
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              title: Text(item.memberName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children:
                                item.getDisplayLines().map((line) => Text(line)).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                }
              }),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Obx(
                  () {
                // Start with a list and add "All" option first
                List<DropdownMenuItem<String>> dropdownItems = [
                  const DropdownMenuItem(
                    value: null,
                    child: Text("All"),
                  ),
                ];

                // Add other leave types
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
              },
            ),
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
