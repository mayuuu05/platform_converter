import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/data_controller.dart';

class DatePickerRow extends StatelessWidget {
  final ConverterController controller;

  const DatePickerRow({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              selectableDayPredicate: (day) {
                controller.date = day.year.toString() +
                    "-" +
                    day.month.toString() +
                    "-" +
                    day.day.toString();
                return true;
              },
            );
          },
          child: Icon(
            Icons.calendar_month_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: height * 0.030,
          ),
        ),
        Text(
          '   Pick Date',
          style: TextStyle(

              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18),
        ),
      ],
    ).marginOnly(left: 15, top: 10);
  }
}