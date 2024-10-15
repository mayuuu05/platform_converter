import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final Color? labelColor;
  final Color? borderColor;
  final double? borderWidth;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.label,
    this.labelColor,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: labelColor ?? null),
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor ?? Colors.black,
        ),
        focusedBorder: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
            width: borderWidth ?? 1,
          ),
        ),
      ),
    ).marginSymmetric(horizontal: 15, vertical: 8);
  }
}