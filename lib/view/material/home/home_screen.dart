import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controller/data_controller.dart';
import '../../../controller/tab_controller.dart';
import '../call/call_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import '../setting/setting_screen.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(TabBarController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Material App',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        leading: Icon(Icons.menu),
        centerTitle: true,
        actions: [
          Obx(
                () =>  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Switch(
                    activeColor: (themeController.isDarkMode.value)?Colors.green:Colors.green,
                                value: controller.platformConverter.value,
                                onChanged: (value) {
                  controller.platformConverter.value=value;
                                },
                              ),
                ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: TabBar(
            controller: tabController,
            indicatorColor:  Theme.of(context).colorScheme.onPrimaryContainer,
            indicatorWeight: 3.0,
            labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            labelStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 13.0,
            ),
            tabs: const [
              Tab(text: 'ADD'),
              Tab(text: 'CHATS'),
              Tab(text: 'CALLS'),
              Tab(text: 'SETTINGS'),
            ],
          ),
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        ProfileScreen(),
        Chatscreen(),
        Callscreen(),
        Setting(),
      ]),
    );
  }
}

late TabController tabController;