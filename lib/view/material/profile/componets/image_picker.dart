import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/data_controller.dart';

class ProfileImagePicker extends StatelessWidget {
  final ConverterController controller;
  final double height;

  const ProfileImagePicker({
    Key? key,
    required this.controller,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        controller.fileImagePath.value = "";
        ImagePicker image = ImagePicker();
        XFile? xfile = await image.pickImage(source: ImageSource.gallery);
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
          backgroundImage: (controller.fileImagePath.value == "")
              ? null
              : FileImage(controller.ImgPath!.value),
          child: (controller.fileImagePath.value == "")
              ? Icon(Icons.add_a_photo_outlined, size: height * 0.035)
              : null,
        ).marginOnly(top: height * 0.020, bottom: height * 0.030),
      ),
    );
  }
}