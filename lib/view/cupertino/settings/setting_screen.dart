import 'dart:io';

import 'package:contact_diary_platform_converter/view/material/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/data_controller.dart';
import '../../../controller/tab_controller.dart';

class CupertinoSettingScreen extends StatelessWidget {
  const CupertinoSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TabBarController());
    var converterController = Get.put(ConverterController());

    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          child: Obx(
                () => SingleChildScrollView(
              child: Column(
                children: [
                  CupertinoListTile(
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        color: CupertinoColors.activeBlue,),
                    ),
                    subtitle: Text(
                      'Update Profile Data',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    leading: Icon(
                      CupertinoIcons.person,
                      color: CupertinoColors.activeBlue,
                      size: 30,
                    ),
                    trailing: Obx(
                          () => CupertinoSwitch(
                        value: controller.profile.value,
                        onChanged: (value) {
                          controller.profile.value = value;
                        },
                      ).marginOnly(right: 15),
                    ),
                  ),
                  (controller.profile.value == true)
                      ? Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          converterController.fileImagePath.value = "";
                          ImagePicker image = ImagePicker();
                          XFile? xfile = await image.pickImage(
                              source: ImageSource.gallery);
                          String path = xfile!.path;
                          File fileImage = File(path);
                          converterController.setImg(fileImage);
                          if (converterController.ImgPath != null) {
                            converterController.fileImagePath.value =
                            "image";
                          }
                        },
                        child: Obx(
                              () =>  ClipOval(
                            child: Container(
                              height: 150,
                              width: 150,
                              color: CupertinoColors.activeBlue,
                              alignment: Alignment.center,
                              child: (converterController
                                  .fileImagePath.value ==
                                  "")
                                  ? Icon(
                                CupertinoIcons.camera,
                                color: Colors.white,
                                size: 35,
                              )
                                  : Image(
                                image: FileImage(
                                    converterController.ImgPath!.value),fit: BoxFit.cover,width: 150,
                              ),
                            ),
                          ).marginOnly(top: 10, bottom: 15),
                        ),
                      ).marginOnly(top: 10,bottom: 15),
                      CupertinoTextField(
                        controller: converterController.txtName,
                        placeholder: 'Enter your name...',
                        textAlign: TextAlign.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,

                            )),
                      ),
                      CupertinoTextField(
                        controller: converterController.txtChat,
                        placeholder: 'Enter your bio...',
                        textAlign: TextAlign.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            )),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: CupertinoColors
                                        .activeBlue),
                              )),
                          TextButton(
                              onPressed: () {
                                converterController.txtName.clear();
                                converterController.txtPhone.clear();
                                converterController.txtChat.clear();
                                converterController.fileImagePath.value = "";
                                converterController.time = "";
                                converterController.date = "";
                              },
                              child: Text(
                                'CLEAR',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: CupertinoColors
                                        .activeBlue),
                              )),
                          Spacer(),
                        ],
                      ),
                    ],
                  )
                      : SizedBox(
                    height: 0,
                  ),
                  CupertinoListTile(
                    title: Text(
                      'Theme',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        color: CupertinoColors.activeBlue,
                         ),
                    ),
                    subtitle: Text(
                      'Change Theme',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    leading: Icon(
                      CupertinoIcons.sun_max,
                      color: CupertinoColors.activeBlue,
                      size: 30,
                    ),
                      trailing: Obx(
                            () => CupertinoSwitch(
                              value: themeController.isDarkMode.value,
                              onChanged: (value) {
                                themeController.toggleTheme();
                              },
                            ).marginOnly(right: 15),
                      )

                  ).marginOnly(top: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
