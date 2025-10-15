import 'dart:async';
import 'package:frontend_coding_challenge/models/members_model.dart';
import 'package:frontend_coding_challenge/network/response/api_response.dart';
import 'package:frontend_coding_challenge/repository/employee_absence_repository.dart';
import 'package:get/get.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';

class MembersController extends GetxController {
  // Observable ApiResponse for managing UI state
  Rx<ApiResponse<List<MemberPayload>>> apiResponse =
      ApiResponse<List<MemberPayload>>(Status.LOADING, null, null).obs;

  @override
  void onInit() {
    super.onInit();
    loadMembers();
  }

  void loadMembers() async {
    try {
      apiResponse.value = ApiResponse.loading(message: "Loading members...");

      // Artificial delay to visualize loader
      await Future.delayed(const Duration(seconds: 2));

      final data = await members();
      final membersList =
      data.map((e) => MemberPayload.fromJson(e)).toList();

      apiResponse.value = ApiResponse.success(
        data: membersList,
        message: "Members loaded successfully",
      );
    } catch (e) {
      apiResponse.value = ApiResponse.error(
        message: "Failed to load members: $e",
      );
      print("Error loading members: $e");
    }
  }

}
