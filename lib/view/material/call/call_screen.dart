import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controller/data_controller.dart';

class Callscreen extends StatelessWidget {
  const Callscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var controller = Get.put(ConverterController());

    void _makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,

      );
      if (await canLaunchUrl(launchUri.toString() as Uri)) {
        await launchUrl(launchUri.toString() as Uri);
      } else {
        throw 'Could not launch $launchUri';
      }
    }

    return Obx(
          () => (controller.data.isEmpty)
          ? Center(
        child: Text(
          'No any calls yet...',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      )
          : ListView.builder(
        itemCount: controller.data.length,
        itemBuilder: (context, index) {
          // Ensure null safety by providing default values
          final String name = controller.data[index]['name'] ?? 'Unknown';
          final String bio = controller.data[index]['bio'] ?? 'No bio available';
          final String phone = controller.data[index]['phone'] ?? '';
          final String imgPath = controller.data[index]['img'] ?? '';

          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    width: double.infinity,
                    height: height * 0.400,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: height * 0.080,
                          backgroundImage: imgPath.isNotEmpty
                              ? FileImage(File(imgPath))
                              : null, // Handle if image is not available
                        ).marginOnly(top: height * 0.025, bottom: height * 0.005),
                        Text(
                          name,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 22),
                        ),
                        Text(
                          bio,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).colorScheme.secondary,
                                  size: height * 0.035,
                                )),
                            IconButton(
                                onPressed: () {
                                  controller.removeData(controller.data[index]['id']);
                                  Get.back();
                                },
                                icon: Icon(Icons.delete,
                                    color: Theme.of(context).colorScheme.secondary,
                                    size: height * 0.035)),
                            Spacer(),
                          ],
                        ).marginOnly(top: height * 0.015),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 18),
                          ),
                        ).marginOnly(top: height * 0.015),
                      ],
                    ),
                  );
                },
              );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: height * 0.040,
                      backgroundImage: imgPath.isNotEmpty
                          ? FileImage(File(imgPath))
                          : null, // Handle if image is not available
                    ).marginOnly(right: 20),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '$name\n',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20)),
                        TextSpan(
                            text: bio,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 18,
                                )),
                      ]),
                    ),

                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (phone.isNotEmpty) {
                          _makePhoneCall(phone);
                        }
                      },
                      child: Icon(Icons.call, color: Colors.green),
                    ),
                  ],
                ).marginSymmetric(horizontal: 15, vertical: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
