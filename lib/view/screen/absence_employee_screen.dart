import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend_coding_challenge/viewmodels/controllers/absence_controller.dart';

class AbsenceEmployeeScreen extends StatelessWidget {
  AbsenceEmployeeScreen({super.key});

  final AbsencesController controller = Get.put(AbsencesController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !controller.pagingController.isPaginating.value &&
          !controller.pagingController.isLastPage.value) {
        controller.pagingController.loadNextPage();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Absences"),
        centerTitle: true,
      ),
      body: Obx(() {
        final absences = controller.pagingController.absences;

        // Show "No data" if empty
        if (absences.isEmpty) {
          return const Center(child: Text("No absences found"));
        }

        return RefreshIndicator(
          onRefresh: controller.pagingController.refreshList,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: absences.length,
            itemBuilder: (context, index) {
              final item = absences[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    item.memberImage != null ? NetworkImage(item.memberImage!) : null,
                    child: item.memberImage == null ? const Icon(Icons.person) : null,
                  ),
                  title: Text(item.memberName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: item.getDisplayLines().map((line) => Text(line)).toList(),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
