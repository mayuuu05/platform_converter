
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/data_controller.dart';

class TimePickerRow extends StatelessWidget {
  final Function(BuildContext) selectTime;
  final ConverterController controller;

  const TimePickerRow({
    Key? key,
    required this.selectTime,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selectTime(context);
          },
          child: Icon(
            Icons.watch_later_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: height * 0.030,
          ),
        ),
        Text(
          '   Pick Time',
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,

              fontSize: 18),
        ),
      ],
    ).marginOnly(left: 15, top: 15, bottom: 15);
  }
}