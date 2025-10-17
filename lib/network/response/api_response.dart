import 'package:flutter/widgets.dart';
import 'package:frontend_coding_challenge/network/response/status.dart';
import 'package:frontend_coding_challenge/utils/utils.dart';
import 'package:get/get.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message) {
    _handleLoading();
  }

  ApiResponse.loading({this.message}) : status = Status.LOADING {
    _handleLoading();
  }

  ApiResponse.success({this.data, this.message}) : status = Status.SUCCESS {
    _handleLoading();
  }

  ApiResponse.error({this.message}) : status = Status.ERROR {
    _handleLoading();
  }

  ApiResponse.empty({this.message}) : status = Status.EMPTY {
    _handleLoading();
  }

  void _handleLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (status == Status.LOADING) {
        await utils.startLoading(Get.context!);
      } else if (status == Status.SUCCESS || status == Status.ERROR || status == Status.EMPTY) {
        await utils.stopLoading();
      }
    });
  }

  @override
  String toString() {
    return "Status : $status\nMessage : $message\nData : $data";
  }
}
