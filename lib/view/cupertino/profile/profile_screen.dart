import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/data_controller.dart';
import '../../../controller/tab_controller.dart';

class CupertinoProfileScreen extends StatelessWidget {
  const CupertinoProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var controller = Get.put(TabBarController());
    var converterController = Get.put(ConverterController());

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        converterController.time = "${pickedTime.hour}:${pickedTime.minute}";
      }
    }

    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () async {
                    converterController.fileImagePath.value = "";
                    ImagePicker image = ImagePicker();
                    XFile? xfile = await image.pickImage(source: ImageSource.gallery);
                    if (xfile != null) {
                      File fileImage = File(xfile.path);
                      converterController.setImg(fileImage);
                      converterController.fileImagePath.value = "image";
                    }
                  },
                  child: Obx(
                        () => ClipOval(
                      child: Container(
                        height: width * 0.4,
                        width: width * 0.4,
                        color: Get.theme.brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Colors.grey[200],
                        alignment: Alignment.center,
                        child: (converterController.fileImagePath.value == "")
                            ? Icon(
                          CupertinoIcons.camera,
                          color: Colors.white,
                          size: 35,
                        )
                            : Image(
                          image: FileImage(converterController.ImgPath!.value),
                          fit: BoxFit.cover,
                          width: width * 0.4,
                        ),
                      ),
                    ).marginOnly(top: 10, bottom: 15),
                  ),
                ),
                // Updated TextField Widgets with Prefix Icons
                _buildTextField(
                  context,
                  icon: CupertinoIcons.person,
                  controller: converterController.txtName,
                  placeholder: 'Full Name',
                ),
                _buildTextField(
                  context,
                  icon: CupertinoIcons.phone,
                  controller: converterController.txtPhone,
                  placeholder: 'Phone Number',
                ),
                _buildTextField(
                  context,
                  icon: CupertinoIcons.chat_bubble_text,
                  controller: converterController.txtChat,
                  placeholder: 'Chat Conversation',
                ),
                SizedBox(height: 20,),

                _buildDatePicker(context, converterController),
                _buildTimePicker(context, _selectTime),
                CupertinoButton(
                  child: Text(
                    'SAVE',

                  ),
                  onPressed: () {
                    converterController.insertData(
                      converterController.ImgPath!.value.path,
                      converterController.time,
                      converterController.date,
                      converterController.txtChat.text,
                      converterController.txtPhone.text,
                      converterController.txtName.text,
                    );
                    // Clear the fields after saving
                    converterController.txtName.clear();
                    converterController.txtPhone.clear();
                    converterController.txtChat.clear();
                    converterController.fileImagePath.value = "";
                    converterController.time = "";
                    converterController.date = "";
                  },
                  color: CupertinoColors.activeBlue,
                ).marginOnly(top: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(BuildContext context, {required IconData icon, required TextEditingController controller, required String placeholder}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7), // Add padding for proper spacing
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        prefix: Padding(
          padding: const EdgeInsets.all(8.0), // Add some padding around the icon
          child: Icon(icon, color: CupertinoColors.activeBlue),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Get.theme.brightness == Brightness.dark ? Colors.white54 : Colors.grey,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, ConverterController converterController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                selectableDayPredicate: (day) {
                  converterController.date = "${day.year}-${day.month}-${day.day}";
                  return true;
                },
              );
            },
            child: Icon(CupertinoIcons.calendar, color: CupertinoColors.activeBlue),
          ),
          const SizedBox(width: 10), // Add spacing between icon and text
          Text(
            'Pick Date',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context, Future<void> Function(BuildContext) selectTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              selectTime(context);
            },
            child: Icon(CupertinoIcons.time, color: CupertinoColors.activeBlue),
          ),
          const SizedBox(width: 10), // Add spacing between icon and text
          Text(
            'Pick Time',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
