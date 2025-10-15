import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';
import 'package:frontend_coding_challenge/viewmodels/controllers/members_controller.dart';
import 'package:get/get.dart';

class AbsenceEmployeeScreen extends StatelessWidget {
  AbsenceEmployeeScreen({super.key});

  final MembersController controller = Get.put(MembersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Members")),
      body: Obx(() {
      final response = controller.apiResponse.value;

      if (response.status == Status.ERROR) {
          return Center(child: Text(response.message ?? "Failed to load data"));
        } else if (response.status == Status.SUCCESS) {
          final membersList = response.data ?? [];
          return ListView.builder(
            itemCount: membersList.length,
            itemBuilder: (context, index) {
              final member = membersList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(member.image ?? ""),
                ),
                title: Text(member.name ?? ""),
                subtitle: Text("User ID: ${member.userId}"),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
