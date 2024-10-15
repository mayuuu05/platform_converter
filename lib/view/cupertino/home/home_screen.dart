import 'dart:io';
import 'package:contact_diary_platform_converter/controller/theme_controller.dart';
import 'package:contact_diary_platform_converter/view/cupertino/chat/chat_screen.dart';
import 'package:contact_diary_platform_converter/view/cupertino/settings/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/data_controller.dart';
import '../../../controller/tab_controller.dart';
import '../../material/call/call_screen.dart';
import '../profile/profile_screen.dart';

class CupertinoScreen extends StatelessWidget {
  const CupertinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TabBarController());
    var converterController = Get.put(ConverterController());
    var themeController = Get.put(ThemeController());

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: const Text(
          'Cupertino App',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
        ),
        actions: [
          Obx(
            () => CupertinoSwitch(
              value: controller.platformConverter.value,
              onChanged: (value) {
                controller.platformConverter.value = value;
              },
            ).marginOnly(right: 15),
          ),
        ],
      ),
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_add),
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2), label: 'CHATS'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone), label: 'CALLS'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'SETTINGS'),
          ],

          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.inactiveGray,
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return const CupertinoProfileScreen();
            case 1:
              return const CupertinoChatScreen();
            case 2:
              return const Callscreen();
            case 3:
              return const CupertinoSettingScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}

File? fileImage;
