import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend_coding_challenge/viewmodels/controllers/absence_controller.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';

class AbsenceEmployeeScreen extends StatelessWidget {
  AbsenceEmployeeScreen({super.key});

  final AbsencesController controller = Get.put(AbsencesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Absences")),
      body: Obx(() {
        final response = controller.apiResponse.value;

        if (response.status == Status.ERROR) {
          return Center(child: Text(response.message ?? "Failed to load data"));
        } else if (response.status == Status.SUCCESS) {
          final list = response.data ?? [];
          if (list.isEmpty) {
            return const Center(child: Text("No absences found"));
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];

              return Card(
                margin:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.memberImage ?? ""),
                  ),
                  title: Text(item.memberName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: item.getDisplayLines()
                        .map((line) => Text(line))
                        .toList(),
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink(); // No loader
      }),
    );
  }
}
