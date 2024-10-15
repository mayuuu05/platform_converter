import 'package:contact_diary_platform_converter/view/cupertino/home/home_screen.dart';
import 'package:contact_diary_platform_converter/view/material/home/home_screen.dart';
import 'package:contact_diary_platform_converter/view/material/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/tab_controller.dart';
import 'controller/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  Get.put(TabBarController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final controller = Get.find<TabBarController>();

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: controller.platformConverter.value
              ? const CupertinoScreen()
              : const MaterialScreen(),
        );
      },
    );
  }
}
