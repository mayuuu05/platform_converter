import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/data_controller.dart';
import '../../../controller/theme_controller.dart';
import 'componets/date_picker.dart';
import 'componets/image_picker.dart';
import 'componets/save_button.dart';
import 'componets/text_field.dart';
import 'componets/time_picker.dart';

var themeController = Get.put(ThemeController());

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ConverterController());

    double height = MediaQuery.of(context).size.height;

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      controller.time = "${pickedTime!.hour}:${pickedTime.minute}";
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileImagePicker(controller: controller, height: height),
          CustomTextField(
            controller: controller.txtName,
            icon: Icons.person,
            label: 'Full Name',
            labelColor: Theme.of(context).colorScheme.secondary,
          ),
          CustomTextField(
            controller: controller.txtPhone,
            icon: Icons.call,
            label: 'Phone Number',
            labelColor: Theme.of(context).colorScheme.secondary,
          ),
          CustomTextField(
            controller: controller.txtChat,
            icon: Icons.chat_outlined,
            label: 'Chat Conversation',
            labelColor: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 10,),
          DatePickerRow(controller: controller),
          TimePickerRow(selectTime: _selectTime, controller: controller),
          const SizedBox(height: 10,),
          SaveButton(controller: controller)
        ],
      ),
    );
  }
}









