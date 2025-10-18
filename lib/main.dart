import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/res/routes/routes.dart';
import 'package:frontend_coding_challenge/res/routes/routes_name.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        // colorScheme: AppThemeColors.lightColorScheme,
        // textTheme: AppFonts.lightTextTheme,
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splashScreen,
      getPages: AppRoutes.appRoute(),
    );
  }
}
