import 'dart:io';
import 'package:contact_diary_platform_converter/controller/theme_controller.dart';
import 'package:contact_diary_platform_converter/view/material/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/data_controller.dart';

class CupertinoChatScreen extends StatelessWidget {
  const CupertinoChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var converterController = Get.put(ConverterController());
    var themeController = Get.put(ThemeController());
    bool dark = themeController.isDarkMode.value;


    return Obx(
          () => converterController.data.isEmpty
          ? CupertinoTabView(
        builder: (BuildContext context) {
          return CupertinoPageScaffold(

            child: Center(
              child: Text(
                'No any chats yet...',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      )
          : ListView.builder(
        itemCount: converterController.data.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text(
                    'Actions',
                    style: TextStyle(),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Get.back();
                        _showUpdateDialog(
                            context, converterController, index, height);
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        converterController.removeData(
                            converterController.data[index]['id']);
                        Get.back();
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  leading: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.035,
                    backgroundImage: FileImage(File(converterController.data[index]['img'])),
                  ),
                  title: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${converterController.data[index]['name']}\n',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: '${converterController.data[index]['bio']}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Text(
                    '${converterController.data[index]['date']}, ${converterController.data[index]['time']}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, ConverterController controller,
      int index, double height) {
    controller.txtName.text = controller.data[index]['name'];
    controller.txtPhone.text = controller.data[index]['call'];
    controller.txtChat.text = controller.data[index]['bio'];
    controller.fileImagePath.value = ""; // Reset for image update

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Data'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  controller.fileImagePath.value = "";
                  ImagePicker image = ImagePicker();
                  XFile? xfile =
                  await image.pickImage(source: ImageSource.gallery);
                  if (xfile != null) {
                    String path = xfile.path;
                    File fileImage = File(path);
                    controller.setImg(fileImage);
                    if (controller.ImgPath != null) {
                      controller.fileImagePath.value = "image";
                    }
                  }
                },
                child: Obx(
                      () => CircleAvatar(
                    radius: height * 0.050,
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    backgroundImage: (controller.fileImagePath.value == "image")
                        ? FileImage(controller.ImgPath!.value)
                        : FileImage(controller.ImgPath!.value),
                  ).marginOnly(top: height * 0.020, bottom: height * 0.030),
                ),
              ),
              _buildTextField(context, controller.txtName, 'Full Name', Icons.person_outline),
              _buildTextField(context, controller.txtPhone, 'Phone Number', Icons.call),
              _buildTextField(context, controller.txtChat, 'Chat Conversation', Icons.chat_outlined),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Update logic
              String name = controller.txtName.text;
              String phone = controller.txtPhone.text;
              String chat = controller.txtChat.text;
              String img = controller.fileImagePath.value == "image"
                  ? controller.ImgPath!.value.path
                  : controller.data[index]['img'];
              int id = controller.data[index]['id'];

              // Call the updateData method
              controller.updateData(name, phone, chat, img, id);
              Get.back();
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              controller.txtName.clear();
              controller.txtPhone.clear();
              controller.txtChat.clear();
              controller.fileImagePath.value = "";
              Get.back();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller,
      String labelText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.secondary,
        ),
        focusedBorder: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 2,
          ),
        ),
      ),
    ).marginOnly(bottom: 10);
  }
}
