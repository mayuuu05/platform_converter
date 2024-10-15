import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart'; // Added for CupertinoDialog

import '../../../controller/data_controller.dart';

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var controller = Get.put(ConverterController());

    return Obx(
          () => (controller.data.isEmpty)
          ? Center(
        child: Text(
          'No chats yet...',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      )
          : ListView.builder(
        itemCount: controller.data.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {

            controller.txtName.text = controller.data[index]['name'];
            controller.txtPhone.text = controller.data[index]['call'];
            controller.txtChat.text = controller.data[index]['bio'];
            controller.fileImagePath.value = controller.data[index]['img'];

            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('Actions'),
                  content: Text('Choose an action:'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('Update'),
                      onPressed: () {
                        Navigator.of(context).pop();
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
                                      XFile? xfile = await image.pickImage(source: ImageSource.gallery);
                                      if (xfile != null) {
                                        String path = xfile.path;
                                        File fileImage = File(path);
                                        controller.setImg(fileImage);
                                        controller.fileImagePath.value = "image";
                                      }
                                    },
                                    child: Obx(
                                          () => CircleAvatar(
                                        radius: height * 0.050,
                                        backgroundImage: (controller.fileImagePath.value == "image")
                                            ? FileImage(controller.ImgPath!.value)
                                            : FileImage(File(controller.data[index]['img'])),
                                      ).marginOnly(top: height * 0.020, bottom: height * 0.030),
                                    ),
                                  ),
                                  _buildTextField(
                                    context,
                                    controller.txtName,
                                    'Full Name',
                                    Icons.person_outline,
                                  ),
                                  _buildTextField(
                                    context,
                                    controller.txtPhone,
                                    'Phone Number',
                                    Icons.call,
                                  ),
                                  _buildTextField(
                                    context,
                                    controller.txtChat,
                                    'Chat Conversation',
                                    Icons.chat_outlined,
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  String name = controller.txtName.text;
                                  String phone = controller.txtPhone.text;
                                  String chat = controller.txtChat.text;
                                  String img = controller.fileImagePath.value == "image"
                                      ? controller.ImgPath!.value.path
                                      : controller.data[index]['img'];
                                  int id = controller.data[index]['id'];

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
                                  Get.back(); // Close the dialog
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('Delete'),
                      onPressed: () {
                        controller.removeData(controller.data[index]['id']);
                        Navigator.pop(context);
                      },
                      isDestructiveAction: true,
                    ),
                    CupertinoDialogAction(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
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

                Row(
                  children: [
                    CircleAvatar(
                      radius: height * 0.040,
                      backgroundImage: FileImage(
                        File(controller.data[index]['img']),
                      ),
                    ).marginOnly(right: 20),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${controller.data[index]['name']}\n',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: '${controller.data[index]['bio']}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${controller.data[index]['date']}, ${controller.data[index]['time']}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ],
                ).marginSymmetric(horizontal: 15, vertical: 10),
              ],
            ),
          ),
        ),
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

        ),
      ),
    ).marginOnly(bottom: 10);
  }
}
