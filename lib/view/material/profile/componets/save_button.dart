import 'package:flutter/material.dart';

import '../../../../controller/data_controller.dart';

class SaveButton extends StatelessWidget {
  final ConverterController controller;

  const SaveButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        controller.insertData(
          controller.ImgPath!.value.path,
          controller.time,
          controller.date,
          controller.txtChat.text,
          controller.txtPhone.text,
          controller.txtName.text,
        );
        controller.txtName.clear();
        controller.txtPhone.clear();
        controller.txtChat.clear();
        controller.fileImagePath.value = "";
        controller.time = "";
        controller.date = "";
      },
      child: const Text(
        'SAVE',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}