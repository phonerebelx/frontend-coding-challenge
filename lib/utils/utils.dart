import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_coding_challenge/res/colors/colors.dart';
import 'package:get/get.dart';

enum ToastAlignment { top, center, bottom }

class utils {
  static bool _isDialogOpen = false;

  static void toastMessages(String msg, ToastAlignment alignment) {
    ToastGravity gravity;

    switch (alignment) {
      case ToastAlignment.top:
        gravity = ToastGravity.TOP;
        break;
      case ToastAlignment.center:
        gravity = ToastGravity.CENTER;
        break;
      case ToastAlignment.bottom:
        gravity = ToastGravity.BOTTOM;
        break;
    }

    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: colors.blackColor,
      textColor: colors.whiteColor,
      gravity: gravity,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 12.0,
    );
  }

  static void snackBar(String title, String message) {
    Get.snackbar(title, message);
  }

  static Future<void> startLoading(BuildContext context) async {
    if (_isDialogOpen) return; // prevent duplicate loaders
    _isDialogOpen = true;

    Get.dialog(
      const Center(
        child: SpinKitSpinningLines(
          color: colors.orangeColor,
          lineWidth: 5.0,
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> stopLoading() async {
    if (_isDialogOpen && Get.isDialogOpen == true) {
      Get.back(closeOverlays: true);
      _isDialogOpen = false;
    }
  }
}
