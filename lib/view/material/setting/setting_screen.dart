import 'dart:io';

import 'package:contact_diary_platform_converter/view/material/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/data_controller.dart';
import '../../../controller/tab_controller.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var controller = Get.put(ConverterController());
    var tabBarController = Get.put(TabBarController());
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.person,
                size: height * 0.035,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                'Update Profile Data',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15),
              ),
              trailing: Obx(
                () => Switch(
                  value: tabBarController.profile.value,
                  onChanged: (value) {
                    tabBarController.profile.value = value;
                  },
                ),
              ),
            ).marginOnly(top: height * 0.015),
            (tabBarController.profile.value == true)
                ? Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          controller.fileImagePath.value = "";
                          ImagePicker image = ImagePicker();
                          XFile? xfile = await image.pickImage(
                              source: ImageSource.gallery);
                          String path = xfile!.path;
                          File fileImage = File(path);
                          controller.setImg(fileImage);
                          if (controller.ImgPath != null) {
                            controller.fileImagePath.value = "image";
                          }
                        },
                        child: Obx(
                          () => CircleAvatar(
                            radius: height * 0.085,
                            child: (controller.fileImagePath.value == "")
                                ? Icon(
                                    Icons.add_a_photo_outlined,
                                    size: height * 0.035,
                                  )
                                : null,
                            backgroundImage:
                                (controller.fileImagePath.value == "")
                                    ? null
                                    : FileImage(controller.ImgPath!.value),
                          ).marginOnly(
                              top: height * 0.020, bottom: height * 0.030),
                        ),
                      ),
                      TextField(
                        controller: controller.txtName,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Enter your name...',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 18),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                        ),
                      ),
                      TextField(
                        controller: controller.txtChat,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Enter your Bio...',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 18),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              )),
                          SizedBox(width: 20,),
                          OutlinedButton(
                              onPressed: () {
                                controller.txtName.clear();
                                controller.txtPhone.clear();
                                controller.txtChat.clear();
                                controller.fileImagePath.value = "";
                                controller.time = "";
                                controller.date = "";
                              },
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              )),
                          Spacer(),
                        ],
                      ),
                    ],
                  )
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(height: 10,),
            Divider(
              thickness: 1,
            ).marginSymmetric(horizontal: 15),
            ListTile(
              leading: Icon(
                Icons.light_mode,
                size: height * 0.030,
              ),
              title: Text(
                'Theme',
                style: TextStyle(
                    fontSize: 18),
              ),
              subtitle: Text(
                'Change Theme',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,

                    fontSize: 15),
              ),
              trailing: Obx(
                () => Switch(
                  value: themeController.isDarkMode.value,
                  onChanged: (value) {
                    themeController.isDarkMode.value = value;
                  },
                ),
              ),
            ).marginOnly(top: height * 0.015),
          ],
        ),
      ),
    );
  }
}
