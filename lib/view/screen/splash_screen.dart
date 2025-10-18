import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/res/assets/assets_conf.dart';
import 'package:frontend_coding_challenge/res/colors/colors.dart';
import 'package:frontend_coding_challenge/viewmodels/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {


  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Initialize controller
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: colors.blackColor,
      body: Center(
        child: Image.asset(
          ImageAssets.crewmeister,
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
