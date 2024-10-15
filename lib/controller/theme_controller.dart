import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeFromPreferences();
  }
  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    saveThemeToPreferences(isDarkMode.value);
  }

  Future<void> saveThemeToPreferences(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  Future<void> loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
  }

  ThemeData get themeData => isDarkMode.value ? ThemeData.dark() : ThemeData.light();
}
